#!/usr/bin/env bash

# 16进制颜色转ANSI真彩色函数
hex_to_ansi() {
    local hex=$1
    # 去除#号
    hex=${hex#"#"}
    
    # 处理缩写格式 #RGB => RRGGBB
    if [ ${#hex} -eq 3 ]; then
        hex="${hex:0:1}${hex:0:1}${hex:1:1}${hex:1:1}${hex:2:1}${hex:2:1}"
    fi

    # 转换为RGB数值
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    
    # 返回ANSI转义序列
    printf "\033[38;2;%d;%d;%dm" $r $g $b
}

# 定义颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 恢复默认颜色

PROFILE_FILE="/sys/firmware/acpi/platform_profile"

if [[ ! -f "$PROFILE_FILE" ]]; then
	echo -e "${RED}✗ 未找到配置文件:${NC} $PROFILE_FILE"
	echo -e "${BLUE}内核模块可能未成功安装${NC}"
	exit 127
fi

# 定义mode字体颜色
LOW_POWER=$(hex_to_ansi "#5DFF00") 
QUIET=$(hex_to_ansi "#E5FFFC") 
BALANCED=$(hex_to_ansi "#69CDFF") 
BALANCED_PERFORMANCE=$(hex_to_ansi "#DC73FF") 
PERFORMANCE=$(hex_to_ansi "#FF73ED") 

# 帮助信息
show_help() {
    echo -e "  ${YELLOW}Usage: $0 [0|1|2|3|4]${NC}"
    echo -e "  ${BLUE}Set platform power profile:${NC}"
    echo -e "  ${BLUE}0${NC}  ${LOW_POWER}Low Power${NC}"
    echo -e "  ${BLUE}1${NC}  ${QUIET}Quiet${NC}"
    echo -e "  ${BLUE}2${NC}  ${BALANCED}Balanced${NC}"
    echo -e "  ${BLUE}3${NC}  ${BALANCED_PERFORMANCE}Balanced Performance${NC}"
    echo -e "  ${BLUE}4${NC}  ${PERFORMANCE}Performance${NC}"
    exit 0
}

# 参数验证
if [[ $# -ne 1 ]] || [[ "$1" =~ [^0-9] ]]; then
    echo -e "${RED}✗ 必须指定一个0-4的整数参数${NC}"
    show_help
    exit 1
fi

declare -a profiles_display=(
    "${LOW_POWER}low-power${NC}"
    "${QUIET}quiet${NC}"
    "${BALANCED}balanced${NC}"
    "${BALANCED_PERFORMANCE}balanced-performance${NC}"
    "${PERFORMANCE}performance${NC}"
)
declare -a profiles=(
    "low-power"
    "quiet"
    "balanced"
    "balanced-performance"
    "performance"
)

selected=$1

# 检查参数范围
if (( selected < 0 || selected > 4 )); then
    echo -e "${RED}✗ 无效参数：请输入0-4的整数${NC}"
    show_help
    exit 1
fi

# 获取对应的profile
profile=${profiles[$selected]}
profile_display=${profiles_display[$selected]}      # 获取带颜色的显示字符串

# 执行设置命令
echo -e "${BLUE}» 正在设置电源方案为：${NC} ${profile_display}"
if echo "$profile" | sudo tee /sys/firmware/acpi/platform_profile >/dev/null; then
    echo -e "${GREEN}✓ 已成功应用${NC} ${profile_display}"
else
    echo -e "${RED}✗ 方案设置失败，请检查权限${NC}"
    exit 1
fi
