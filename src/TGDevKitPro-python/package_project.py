#!/usr/bin/env python3
"""
项目打包脚本 - 创建完整的项目发布包
"""

import os
import shutil
import zipfile
from pathlib import Path
from datetime import datetime

def create_project_package():
    """创建完整的项目包"""
    
    # 项目根目录
    project_root = Path(__file__).parent
    
    # 创建打包目录
    package_name = f"CrossPlatformApp-v1.0.0-{datetime.now().strftime('%Y%m%d')}"
    package_dir = project_root / "package" / package_name
    
    # 清理并创建目录
    if package_dir.exists():
        shutil.rmtree(package_dir)
    package_dir.mkdir(parents=True, exist_ok=True)
    
    # 需要包含的文件和文件夹
    include_items = [
        # 核心文件
        "main.py",
        "version.txt",
        "dependencies.txt",
        "BUILD_INSTRUCTIONS.md",
        "README.md",
        "CHANGELOG.md",
        
        # 源代码目录
        "src",
        "config", 
        "resources",
        "build",
    ]
    
    # 排除的文件模式
    exclude_patterns = [
        "__pycache__",
        "*.pyc",
        "*.pyo",
        ".git",
        ".gitignore",
        "dist",
        "venv",
        "*.log",
        "package",
        "output"
    ]
    
    def should_exclude(path_str):
        """检查是否应该排除文件"""
        for pattern in exclude_patterns:
            if pattern in path_str:
                return True
        return False
    
    # 复制文件和目录
    for item in include_items:
        source_path = project_root / item
        if source_path.exists():
            if source_path.is_file():
                # 复制文件
                dest_path = package_dir / item
                dest_path.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(source_path, dest_path)
                print(f"复制文件: {item}")
            else:
                # 复制目录
                dest_path = package_dir / item
                shutil.copytree(source_path, dest_path, 
                              ignore=shutil.ignore_patterns(*exclude_patterns))
                print(f"复制目录: {item}")
        else:
            print(f"警告: 找不到 {item}")
    
    # 创建快速开始脚本
    quick_start_content = '''@echo off
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
'''
    
    with open(package_dir / "快速开始.bat", 'w', encoding='utf-8') as f:
        f.write(quick_start_content)
    
    # 创建Linux/Mac快速开始脚本
    quick_start_unix = '''#!/bin/bash
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
'''
    
    unix_script = package_dir / "快速开始.sh"
    with open(unix_script, 'w', encoding='utf-8') as f:
        f.write(quick_start_unix)
    unix_script.chmod(0o755)
    
    # 创建ZIP包
    zip_path = project_root / f"{package_name}.zip"
    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(package_dir):
            # 排除__pycache__目录
            dirs[:] = [d for d in dirs if not should_exclude(d)]
            
            for file in files:
                if not should_exclude(file):
                    file_path = Path(root) / file
                    arcname = file_path.relative_to(package_dir.parent)
                    zipf.write(file_path, arcname)
    
    print(f"\n项目包创建完成:")
    print(f"- 目录: {package_dir}")
    print(f"- ZIP包: {zip_path}")
    print(f"- 包含build文件夹和所有构建脚本")
    
    return zip_path

if __name__ == "__main__":
    create_project_package()