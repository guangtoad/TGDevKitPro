@echo off
REM Windows Batch Build Script for Python Cross-Platform Application
REM This script builds a Windows executable using PyInstaller

setlocal enabledelayedexpansion

echo ========================================
echo Windows Batch Build Script
echo ========================================

REM Parse command line arguments
set CLEAN=false
set DEBUG=false
set OUTPUT_DIR=dist

:parse_args
if "%~1"=="" goto args_done
if /i "%~1"=="--clean" (
    set CLEAN=true
    shift
    goto parse_args
)
if /i "%~1"=="--debug" (
    set DEBUG=true
    shift
    goto parse_args
)
if /i "%~1"=="--output-dir" (
    set OUTPUT_DIR=%~2
    shift
    shift
    goto parse_args
)
if /i "%~1"=="--help" (
    echo Usage: %~nx0 [--clean] [--debug] [--output-dir DIR] [--help]
    echo.
    echo Options:
    echo   --clean       Clean previous build artifacts
    echo   --debug       Enable debug mode
    echo   --output-dir  Specify output directory (default: dist)
    echo   --help        Show this help message
    echo.
    exit /b 0
)
echo Unknown option: %~1
echo Use --help for usage information
exit /b 1

:args_done

REM Get project root directory
set SCRIPT_DIR=%~dp0
set PROJECT_ROOT=%SCRIPT_DIR%..
cd /d "%PROJECT_ROOT%"

echo Project root: %PROJECT_ROOT%

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python and add it to your PATH
    echo Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)

REM Get Python version
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Python version: %PYTHON_VERSION%

REM Check if virtual environment exists
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
    if errorlevel 1 (
        echo ERROR: Failed to create virtual environment
        pause
        exit /b 1
    )
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat
if errorlevel 1 (
    echo ERROR: Failed to activate virtual environment
    pause
    exit /b 1
)

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
if errorlevel 1 (
    echo WARNING: Failed to upgrade pip, continuing anyway...
)

REM Install requirements
echo Installing requirements...
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install requirements
    echo Please check your internet connection and requirements.txt file
    pause
    goto cleanup
)

REM Clean previous builds if requested
if "%CLEAN%"=="true" (
    echo Cleaning previous builds...
    if exist "dist" rmdir /s /q "dist"
    if exist "build\build" rmdir /s /q "build\build"
)

REM Prepare build arguments
set BUILD_ARGS=build\common_build.py --platform windows

if "%DEBUG%"=="true" (
    set BUILD_ARGS=%BUILD_ARGS% --debug
)

if not "%OUTPUT_DIR%"=="dist" (
    set BUILD_ARGS=%BUILD_ARGS% --output-dir "%OUTPUT_DIR%"
)

REM Run build process
echo Running build process...
echo Command: python %BUILD_ARGS%
python %BUILD_ARGS%
if errorlevel 1 (
    echo ERROR: Build failed
    echo Check the build logs above for details
    pause
    goto cleanup
)

REM Check if executable was created
set EXE_PATH=%OUTPUT_DIR%\CrossPlatformApp.exe
if exist "%EXE_PATH%" (
    echo.
    echo ========================================
    echo BUILD SUCCESSFUL!
    echo ========================================
    echo Executable created at: %EXE_PATH%
    
    REM Get file size
    for %%i in ("%EXE_PATH%") do set FILE_SIZE=%%~zi
    set /a FILE_SIZE_MB=!FILE_SIZE!/1048576
    echo File size: !FILE_SIZE_MB! MB
    
    echo.
    echo You can now distribute this executable to other Windows machines
    echo without requiring Python to be installed.
    echo.
    echo Press any key to open the output directory...
    pause >nul
    explorer "%OUTPUT_DIR%"
) else (
    echo ERROR: Executable not found at expected location: %EXE_PATH%
    echo Build may have failed or output directory is incorrect
    pause
    goto cleanup
)

goto cleanup

:cleanup
REM Deactivate virtual environment
if defined VIRTUAL_ENV (
    call deactivate
)

echo Build script completed.
exit /b 0
