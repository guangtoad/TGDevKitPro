#!/bin/bash

# macOS Build Script for Python Cross-Platform Application
# This script builds a macOS application bundle using PyInstaller

set -e  # Exit on any error

echo "========================================"
echo "macOS Build Script"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${1}${2}${NC}\n"
}

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

print_color $GREEN "Project root: $PROJECT_ROOT"

# Parse command line arguments
CLEAN=false
DEBUG=false
OUTPUT_DIR="dist"

while [[ $# -gt 0 ]]; do
    case $1 in
        --clean)
            CLEAN=true
            shift
            ;;
        --debug)
            DEBUG=true
            shift
            ;;
        --output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--clean] [--debug] [--output-dir DIR]"
            exit 1
            ;;
    esac
done

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    print_color $RED "ERROR: Python 3 is not installed or not in PATH"
    print_color $RED "Please install Python 3 using Homebrew: brew install python"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
print_color $GREEN "Python version: $PYTHON_VERSION"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_color $RED "ERROR: This script is designed for macOS only"
    exit 1
fi

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    print_color $YELLOW "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
print_color $YELLOW "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
print_color $YELLOW "Upgrading pip..."
pip install --upgrade pip

# Install requirements
print_color $YELLOW "Installing requirements..."
pip install -r requirements.txt

# Clean previous builds if requested
if [ "$CLEAN" = true ] || [ -d "dist" ]; then
    print_color $YELLOW "Cleaning previous builds..."
    rm -rf dist
    rm -rf build/build
fi

# Prepare build arguments
BUILD_ARGS=("build/common_build.py" "--platform" "macos")

if [ "$DEBUG" = true ]; then
    BUILD_ARGS+=("--debug")
fi

if [ "$OUTPUT_DIR" != "dist" ]; then
    BUILD_ARGS+=("--output-dir" "$OUTPUT_DIR")
fi

# Run build process
print_color $YELLOW "Running build process..."
python "${BUILD_ARGS[@]}"

# Check if application bundle was created
APP_PATH="$OUTPUT_DIR/CrossPlatformApp.app"
if [ -d "$APP_PATH" ]; then
    echo ""
    print_color $GREEN "========================================"
    print_color $GREEN "BUILD SUCCESSFUL!"
    print_color $GREEN "========================================"
    print_color $GREEN "Application bundle created at: $APP_PATH"
    
    # Get bundle size
    BUNDLE_SIZE=$(du -sh "$APP_PATH" | cut -f1)
    print_color $GREEN "Bundle size: $BUNDLE_SIZE"
    
    # Make the application executable
    chmod +x "$APP_PATH/Contents/MacOS/CrossPlatformApp"
    
    echo ""
    print_color $CYAN "You can now:"
    print_color $CYAN "1. Run the app: open \"$APP_PATH\""
    print_color $CYAN "2. Move it to Applications folder"
    print_color $CYAN "3. Create a DMG for distribution"
    echo ""
    
    # Optional: Create DMG for distribution
    read -p "Do you want to create a DMG file for distribution? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        DMG_NAME="CrossPlatformApp-$(cat version.txt).dmg"
        print_color $YELLOW "Creating DMG: $DMG_NAME"
        
        # Create temporary directory for DMG contents
        DMG_TEMP=$(mktemp -d)
        cp -R "$APP_PATH" "$DMG_TEMP/"
        
        # Create symbolic link to Applications folder
        ln -s /Applications "$DMG_TEMP/Applications"
        
        # Create DMG
        hdiutil create -volname "CrossPlatformApp" -srcfolder "$DMG_TEMP" -ov -format UDZO "$OUTPUT_DIR/$DMG_NAME"
        
        # Clean up
        rm -rf "$DMG_TEMP"
        
        print_color $GREEN "DMG created: $OUTPUT_DIR/$DMG_NAME"
    fi
    
else
    print_color $RED "ERROR: Application bundle not found at expected location: $APP_PATH"
    exit 1
fi

# Deactivate virtual environment
deactivate

print_color $GREEN "Build complete!"
