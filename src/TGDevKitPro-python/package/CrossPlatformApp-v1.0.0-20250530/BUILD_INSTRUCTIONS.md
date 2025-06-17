# 构建说明

## Windows可执行文件构建

### 方法一：PowerShell脚本（推荐）
```powershell
# 在项目根目录执行
.\build\build_windows.ps1
```

### 方法二：批处理脚本
```cmd
# 在项目根目录执行
.\build\build_windows.bat
```

### 方法三：Python脚本
```bash
# 安装依赖
pip install -r dependencies.txt

# 构建Windows exe
python build\common_build.py --platform windows
```

## macOS应用程序构建

### 在macOS系统上执行：
```bash
# 给脚本执行权限
chmod +x build/build_macos.sh

# 执行构建
./build/build_macos.sh
```

### 或使用Python脚本：
```bash
# 安装依赖
pip install -r dependencies.txt

# 构建macOS app
python build/common_build.py --platform macos
```

## 构建选项

### 清理构建
```bash
# PowerShell
.\build\build_windows.ps1 --clean

# Bash
./build/build_macos.sh --clean
```

### 调试模式
```bash
# PowerShell
.\build\build_windows.ps1 --debug

# Bash
./build/build_macos.sh --debug
```

### 自定义输出目录
```bash
# PowerShell
.\build\build_windows.ps1 --output-dir "my_dist"

# Bash
./build/build_macos.sh --output-dir "my_dist"
```

## 输出文件

- **Windows**: `dist/CrossPlatformApp.exe`
- **macOS**: `dist/CrossPlatformApp.app`

## 注意事项

1. 确保已安装Python 3.7或更高版本
2. Windows构建需要在Windows系统上执行
3. macOS构建需要在macOS系统上执行
4. 首次构建会自动创建虚拟环境并安装依赖
5. 构建完成的文件可以在没有Python环境的机器上运行