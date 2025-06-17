#!/bin/bash
echo "安装依赖并启动应用程序..."
echo

# 检查Python是否可用
if ! command -v python3 &> /dev/null; then
    echo "错误: 未找到Python3, 请先安装Python 3.7+"
    exit 1
fi

# 安装依赖
echo "正在安装依赖..."
pip3 install -r dependencies.txt

# 启动应用
echo "启动应用程序..."
python3 main.py --gui
