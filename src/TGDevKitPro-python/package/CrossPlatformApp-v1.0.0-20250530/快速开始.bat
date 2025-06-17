@echo off
echo 安装依赖并启动应用程序...
echo.

REM 检查Python是否可用
python --version >nul 2>&1
if errorlevel 1 (
    echo 错误: 未找到Python, 请先安装Python 3.7+
    pause
    exit /b 1
)

REM 安装依赖
echo 正在安装依赖...
pip install -r dependencies.txt

REM 启动应用
echo 启动应用程序...
python main.py --gui

pause
