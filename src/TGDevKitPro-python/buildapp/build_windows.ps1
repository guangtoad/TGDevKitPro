# Windows PowerShell Build Script for Python Cross-Platform Application
# This script builds a Windows executable using PyInstaller

param(
    [switch]$Clean,
    [switch]$Debug,
    [string]$OutputDir = "dist"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Windows PowerShell Build Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Set error action preference
$ErrorActionPreference = "Stop"

try {
    # Get project root directory
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $ProjectRoot = Split-Path -Parent $ScriptDir
    Set-Location $ProjectRoot
    
    Write-Host "Project root: $ProjectRoot" -ForegroundColor Green
    
    # Check if Python is installed
    try {
        $PythonVersion = python --version
        Write-Host "Python version: $PythonVersion" -ForegroundColor Green
    }
    catch {
        Write-Host "ERROR: Python is not installed or not in PATH" -ForegroundColor Red
        Write-Host "Please install Python and add it to your PATH" -ForegroundColor Red
        exit 1
    }
    
    # Check if virtual environment exists
    if (-not (Test-Path "venv")) {
        Write-Host "Creating virtual environment..." -ForegroundColor Yellow
        python -m venv venv
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to create virtual environment"
        }
    }
    
    # Activate virtual environment
    Write-Host "Activating virtual environment..." -ForegroundColor Yellow
    & "venv\Scripts\Activate.ps1"
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to activate virtual environment"
    }
    
    # Upgrade pip
    Write-Host "Upgrading pip..." -ForegroundColor Yellow
    python -m pip install --upgrade pip
    
    # Install requirements
    Write-Host "Installing requirements..." -ForegroundColor Yellow
    pip install -r requirements.txt
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install requirements"
    }
    
    # Clean previous builds if requested
    if ($Clean -or (Test-Path "dist")) {
        Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
        if (Test-Path "dist") { Remove-Item -Recurse -Force "dist" }
        if (Test-Path "build\build") { Remove-Item -Recurse -Force "build\build" }
    }
    
    # Prepare build arguments
    $BuildArgs = @("build\common_build.py", "--platform", "windows")
    if ($Debug) {
        $BuildArgs += "--debug"
    }
    if ($OutputDir -ne "dist") {
        $BuildArgs += "--output-dir", $OutputDir
    }
    
    # Run build process
    Write-Host "Running build process..." -ForegroundColor Yellow
    python @BuildArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Build failed"
    }
    
    # Check if executable was created
    $ExePath = Join-Path $OutputDir "CrossPlatformApp.exe"
    if (Test-Path $ExePath) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "BUILD SUCCESSFUL!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "Executable created at: $ExePath" -ForegroundColor Green
        
        # Get file size
        $FileSize = (Get-Item $ExePath).Length
        $FileSizeMB = [math]::Round($FileSize / 1MB, 2)
        Write-Host "File size: $FileSizeMB MB" -ForegroundColor Green
        
        Write-Host ""
        Write-Host "You can now distribute this executable to other Windows machines" -ForegroundColor Cyan
        Write-Host "without requiring Python to be installed." -ForegroundColor Cyan
        Write-Host ""
    }
    else {
        throw "Executable not found at expected location: $ExePath"
    }
}
catch {
    Write-Host ""
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Stack trace:" -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    exit 1
}
finally {
    # Deactivate virtual environment
    if (Get-Command deactivate -ErrorAction SilentlyContinue) {
        deactivate
    }
}
