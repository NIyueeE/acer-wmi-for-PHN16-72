#!/bin/bash
set -e

# 配置区（必须与原脚本一致）
CUSTOM_MODULE_PATH="./src/cacer.ko"   # 路径无需修改，仅用于参考
CUSTOM_MODULE_NAME="cacer"            # 自定义模块名称
TARGET_MODULE_DIR="/lib/modules/$(uname -r)/kernel/drivers/misc/"
DISABLE_MODULE="acer_wmi"             # 原禁用的系统模块

# 检查 root 权限
if [ "$(id -u)" -ne 0 ]; then
  echo "错误：请使用 sudo 或以 root 身份运行此脚本！"
  exit 1
fi

# 1. 卸载自定义模块
echo "[1/6] 卸载模块 $CUSTOM_MODULE_NAME..."
if lsmod | grep -q "^${CUSTOM_MODULE_NAME}\s"; then
  modprobe -r "$CUSTOM_MODULE_NAME" || echo "警告：卸载失败，可能仍在使用中"
else
  echo "模块未加载，跳过卸载"
fi

# 2. 删除模块文件
echo "[2/6] 删除模块文件..."
MODULE_FILE="${TARGET_MODULE_DIR}${CUSTOM_MODULE_NAME}.ko"
if [ -f "$MODULE_FILE" ]; then
  rm -v "$MODULE_FILE"
  /sbin/depmod -a
else
  echo "文件 $MODULE_FILE 不存在，跳过删除"
fi

# 3. 移除开机加载配置
echo "[3/6] 清理自动加载配置..."
LOAD_CONF="/etc/modules-load.d/${CUSTOM_MODULE_NAME}.conf"
if [ -f "$LOAD_CONF" ]; then
  rm -v "$LOAD_CONF"
elif grep -qxF "$CUSTOM_MODULE_NAME" /etc/modules 2>/dev/null; then
  echo "从 /etc/modules 中移除条目..."
  sed -i "/^${CUSTOM_MODULE_NAME}$/d" /etc/modules
else
  echo "未找到自动加载配置"
fi

# 4. 恢复禁用模块
echo "[4/6] 恢复模块 $DISABLE_MODULE..."
DISABLE_CONF="/etc/modprobe.d/disable-${DISABLE_MODULE}.conf"
if [ -f "$DISABLE_CONF" ]; then
  rm -v "$DISABLE_CONF"
else
  echo "禁用配置文件不存在"
fi

# 5. 更新 initramfs
echo "[5/6] 重新生成 initramfs..."
if command -v update-initramfs >/dev/null; then
  update-initramfs -u -k all
elif command -v dracut >/dev/null; then
  dracut -f
else
  echo "警告：未找到 initramfs 工具"
fi

# 6. 尝试加载原模块
echo "[6/6] 重新加载 $DISABLE_MODULE..."
if modprobe "$DISABLE_MODULE" 2>/dev/null; then
  echo "模块加载成功"
else
  echo "警告：模块加载失败（可能需要重启）"
fi

rmmod cacer
modprobe acer_wmi

echo -e "\n卸载操作执行完成！建议重启系统使所有更改生效。"
