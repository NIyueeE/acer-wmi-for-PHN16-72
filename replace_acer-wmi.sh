#!/bin/bash
rmmod acer_wmi
set -e

# 配置区（用户需修改以下变量）
CUSTOM_MODULE_PATH="./src/cacer.ko"   # 自定义模块的路径（当前目录示例）
CUSTOM_MODULE_NAME="cacer"        # 自定义模块的名称（不含.ko）
TARGET_MODULE_DIR="/lib/modules/$(uname -r)/kernel/drivers/misc/"  # 目标安装目录
DISABLE_MODULE="acer_wmi"          # 需要禁用的系统模块名

# 检查是否为 root 用户
if [ "$(id -u)" -ne 0 ]; then
  echo "错误：请使用 sudo 或以 root 身份运行此脚本！"
  exit 1
fi

# 1. 复制模块到系统目录并更新依赖
echo "[1/5] 安装自定义模块..."
if [ ! -f "$CUSTOM_MODULE_PATH" ]; then
  echo "错误：模块文件 $CUSTOM_MODULE_PATH 未找到！"
  exit 1
fi
mkdir -p "$TARGET_MODULE_DIR"
cp -v "$CUSTOM_MODULE_PATH" "$TARGET_MODULE_DIR"
/sbin/depmod -a

# 2. 配置开机加载自定义模块
echo "[2/5] 配置自动加载..."
if [ -d /etc/modules-load.d/ ]; then
  echo "$CUSTOM_MODULE_NAME" > /etc/modules-load.d/"$CUSTOM_MODULE_NAME".conf
elif [ -f /etc/modules ]; then
  echo "$CUSTOM_MODULE_NAME" >> /etc/modules
else
  echo "错误：无法确定模块加载配置文件位置！"
  exit 1
fi

# 3. 禁用系统模块
echo "[3/5] 禁用模块 $DISABLE_MODULE..."
DISABLE_CONF="/etc/modprobe.d/disable-$DISABLE_MODULE.conf"
echo "blacklist $DISABLE_MODULE" > "$DISABLE_CONF"
echo "install $DISABLE_MODULE /bin/false" >> "$DISABLE_CONF"

# 4. 更新 initramfs（检测发行版）
echo "[4/5] 更新 initramfs..."
if command -v update-initramfs >/dev/null 2>&1; then
  update-initramfs -u -k all
elif command -v dracut >/dev/null 2>&1; then
  dracut -f
else
  echo "警告：未找到 initramfs 更新工具，跳过此步骤。"
fi

# 5. 加载模块并验证
echo "[5/5] 加载模块并验证..."
/sbin/modprobe "$CUSTOM_MODULE_NAME"

echo "检查当前加载的模块："
if lsmod | grep -q "^${CUSTOM_MODULE_NAME}\s"; then
  echo "成功：$CUSTOM_MODULE_NAME 已加载！"
else
  echo "警告：$CUSTOM_MODULE_NAME 未加载，请检查日志！"
fi

if lsmod | grep -q "^${DISABLE_MODULE}\s"; then
  echo "错误：$DISABLE_MODULE 仍在运行！"
else
  echo "成功：$DISABLE_MODULE 已被禁用！"
fi

echo "脚本执行完毕！请重启系统使所有配置生效。"
