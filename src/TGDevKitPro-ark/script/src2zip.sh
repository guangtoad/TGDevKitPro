#!/bin/bash
# 获取脚本所在目录的绝对路径
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
# 获取父目录
PARENT_DIR=$(dirname "$SCRIPT_DIR")
# 获取父目录的父目录
PARENT_DIR=$(dirname "$PARENT_DIR")
# 输出当前工作目录
echo "$PARENT_DIR"
# 切换到父目录
cd "$PARENT_DIR"

# 获取当前时间，格式为YYYYMMDD_HHMMSS
CURRENT_TIME=$(date +"%Y%m%d%H%M%S")
# 使用时间戳命名zip文件
zipFileName="src${CURRENT_TIME}.zip"

# 压缩eLexusClub_ark目录，排除指定目录
zip -r "$zipFileName" "./src" -x "*/oh_modules/*" "*/\.hvigor/*" "*/\.git/*" "*/build/*" "*/\.preview/*"

# 检查zip文件是否生成
if [ -z "$zipFileName" ]; then
  echo "未找到 zip 文件！"
  exit 1
else
  # 输出生成的zip文件路径
  echo "生成压缩文件路径:$PARENT_DIR/$zipFileName"
  # 打开文件所在目录
  open "$PARENT_DIR"
fi