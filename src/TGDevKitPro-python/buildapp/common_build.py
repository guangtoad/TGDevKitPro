#!/usr/bin/env python3
"""
Common build script for cross-platform Python application.
This script handles the PyInstaller build process for all platforms.
"""

import os
import sys
import argparse
import shutil
import logging
import subprocess
from pathlib import Path
from typing import Optional, List

# Add project root to Python path
script_dir = Path(__file__).parent
project_root = script_dir.parent
sys.path.insert(0, str(project_root))

from config.app_config import AppConfig

class BuildManager:
    """Manages the build process for the application."""
    
    def __init__(self, platform: str, debug: bool = False, output_dir: str = "dist"):
        self.platform = platform.lower()
        self.debug = debug
        self.output_dir = Path(output_dir)
        self.config = AppConfig()
        self.logger = self._setup_logging()
        
        # Validate platform
        valid_platforms = ['windows', 'macos', 'linux']
        if self.platform not in valid_platforms:
            raise ValueError(f"Invalid platform: {platform}. Must be one of {valid_platforms}")
    
    def _setup_logging(self) -> logging.Logger:
        """Setup logging for the build process."""
        log_level = logging.DEBUG if self.debug else logging.INFO
        logging.basicConfig(
            level=log_level,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.StreamHandler(sys.stdout),
                logging.FileHandler('build.log', mode='w')
            ]
        )
        return logging.getLogger(__name__)
    
    def _check_dependencies(self) -> bool:
        """Check if all required dependencies are installed."""
        self.logger.info("Checking dependencies...")
        
        required_packages = ['PyInstaller']
        missing_packages = []
        
        for package in required_packages:
            try:
                # Try to import with common package names
                if package.lower() == 'pyinstaller':
                    import PyInstaller
                else:
                    __import__(package)
                self.logger.debug(f"✓ {package} is installed")
            except ImportError:
                missing_packages.append(package)
                self.logger.warning(f"✗ {package} is not installed")
        
        if missing_packages:
            self.logger.warning(f"Missing packages: {', '.join(missing_packages)}")
            self.logger.info("Attempting to install missing packages...")
            try:
                import subprocess
                for package in missing_packages:
                    result = subprocess.run([
                        sys.executable, '-m', 'pip', 'install', package.lower()
                    ], capture_output=True, text=True, check=True)
                    self.logger.info(f"Successfully installed {package}")
                return True
            except subprocess.CalledProcessError as e:
                self.logger.error(f"Failed to install dependencies: {e}")
                self.logger.error("Please install them manually using: pip install " + " ".join([p.lower() for p in missing_packages]))
                return False
        
        self.logger.info("All dependencies are satisfied")
        return True
    
    def _clean_build_dirs(self) -> None:
        """Clean previous build directories."""
        self.logger.info("Cleaning previous builds...")
        
        dirs_to_clean = [
            self.output_dir,
            script_dir / "build",
            project_root / "__pycache__",
        ]
        
        for dir_path in dirs_to_clean:
            if dir_path.exists():
                self.logger.debug(f"Removing {dir_path}")
                shutil.rmtree(dir_path)
        
        # Clean .pyc files
        for pyc_file in project_root.rglob("*.pyc"):
            pyc_file.unlink()
            self.logger.debug(f"Removed {pyc_file}")
    
    def _generate_version_info(self) -> Optional[Path]:
        """Generate version info file for Windows builds."""
        if self.platform != 'windows':
            return None
        
        version_info_content = f'''
VSVersionInfo(
  ffi=FixedFileInfo(
    filevers=({self.config.VERSION.replace('.', ', ')}, 0),
    prodvers=({self.config.VERSION.replace('.', ', ')}, 0),
    mask=0x3f,
    flags=0x0,
    OS=0x4,
    fileType=0x1,
    subtype=0x0,
    date=(0, 0)
  ),
  kids=[
    StringFileInfo(
      [
      StringTable(
        u'040904B0',
        [StringStruct(u'CompanyName', u'{self.config.AUTHOR}'),
        StringStruct(u'FileDescription', u'{self.config.APP_DESCRIPTION}'),
        StringStruct(u'FileVersion', u'{self.config.VERSION}'),
        StringStruct(u'InternalName', u'{self.config.APP_NAME}'),
        StringStruct(u'LegalCopyright', u'© {self.config.AUTHOR}'),
        StringStruct(u'OriginalFilename', u'{self.config.APP_NAME}.exe'),
        StringStruct(u'ProductName', u'{self.config.APP_NAME}'),
        StringStruct(u'ProductVersion', u'{self.config.VERSION}')])
      ]),
    VarFileInfo([VarStruct(u'Translation', [1033, 1200])])
  ]
)
'''
        
        version_file = script_dir / "version_info.py"
        with open(version_file, 'w') as f:
            f.write(version_info_content)
        
        self.logger.debug(f"Generated version info file: {version_file}")
        return version_file
    
    def _build_with_pyinstaller(self) -> bool:
        """Run PyInstaller to build the application."""
        self.logger.info(f"Building for {self.platform}...")
        
        # Prepare PyInstaller arguments
        pyinstaller_args = [
            'pyinstaller',
            '--clean',
            '--noconfirm',
            f'--distpath={self.output_dir}',
            f'--workpath={script_dir / "build"}',
        ]
        
        # Platform-specific arguments
        if self.platform == 'windows':
            pyinstaller_args.extend([
                '--onefile',
                f'--icon={self.config.RESOURCES_DIR / "icon.ico"}',
            ])
            
            version_file = self._generate_version_info()
            if version_file:
                pyinstaller_args.append(f'--version-file={version_file}')
            
            if not self.debug and self.config.GUI_AVAILABLE:
                pyinstaller_args.append('--windowed')
        
        elif self.platform == 'macos':
            pyinstaller_args.extend([
                '--onedir',  # Use onedir for better app bundle support
                f'--icon={self.config.RESOURCES_DIR / "icon.icns"}',
                '--windowed',
            ])
        
        else:  # Linux
            pyinstaller_args.extend([
                '--onefile',
            ])
        
        # Add debug options
        if self.debug:
            pyinstaller_args.extend(['--debug=all', '--console'])
        
        # Add the spec file or main script
        spec_file = script_dir / "pyinstaller_config.spec"
        if spec_file.exists():
            pyinstaller_args.append(str(spec_file))
        else:
            pyinstaller_args.append(str(project_root / "main.py"))
        
        # Run PyInstaller
        self.logger.info(f"Running: {' '.join(pyinstaller_args)}")
        
        try:
            result = subprocess.run(
                pyinstaller_args,
                cwd=project_root,
                capture_output=True,
                text=True,
                check=True
            )
            
            self.logger.debug("PyInstaller stdout:")
            self.logger.debug(result.stdout)
            
            if result.stderr:
                self.logger.warning("PyInstaller stderr:")
                self.logger.warning(result.stderr)
            
            return True
            
        except subprocess.CalledProcessError as e:
            self.logger.error(f"PyInstaller failed with return code {e.returncode}")
            self.logger.error("stdout:", e.stdout)
            self.logger.error("stderr:", e.stderr)
            return False
    
    def _post_build_processing(self) -> None:
        """Perform post-build processing."""
        self.logger.info("Performing post-build processing...")
        
        # Copy additional files
        additional_files = [
            project_root / "README.md",
            project_root / "CHANGELOG.md",
            project_root / "version.txt",
        ]
        
        for file_path in additional_files:
            if file_path.exists():
                dest_path = self.output_dir / file_path.name
                shutil.copy2(file_path, dest_path)
                self.logger.debug(f"Copied {file_path} to {dest_path}")
        
        # Platform-specific post-processing
        if self.platform == 'macos':
            self._post_process_macos()
        elif self.platform == 'windows':
            self._post_process_windows()
    
    def _post_process_macos(self) -> None:
        """Post-process macOS app bundle."""
        app_bundle = self.output_dir / f"{self.config.APP_NAME}.app"
        if app_bundle.exists():
            # Make executable
            executable_path = app_bundle / "Contents" / "MacOS" / self.config.APP_NAME
            if executable_path.exists():
                os.chmod(executable_path, 0o755)
                self.logger.debug(f"Made executable: {executable_path}")
    
    def _post_process_windows(self) -> None:
        """Post-process Windows executable."""
        exe_path = self.output_dir / f"{self.config.APP_NAME}.exe"
        if exe_path.exists():
            self.logger.debug(f"Windows executable ready: {exe_path}")
    
    def build(self) -> bool:
        """Execute the complete build process."""
        try:
            self.logger.info(f"Starting build process for {self.platform}")
            self.logger.info(f"Application: {self.config.APP_NAME} v{self.config.VERSION}")
            
            # Check dependencies
            if not self._check_dependencies():
                return False
            
            # Clean previous builds
            self._clean_build_dirs()
            
            # Create output directory
            self.output_dir.mkdir(parents=True, exist_ok=True)
            
            # Build with PyInstaller
            if not self._build_with_pyinstaller():
                return False
            
            # Post-build processing
            self._post_build_processing()
            
            self.logger.info("Build completed successfully!")
            return True
            
        except Exception as e:
            self.logger.error(f"Build failed: {e}", exc_info=True)
            return False

def main():
    """Main entry point for the build script."""
    parser = argparse.ArgumentParser(
        description="Cross-platform build script for Python application"
    )
    
    parser.add_argument(
        "--platform",
        choices=["windows", "macos", "linux"],
        required=True,
        help="Target platform for the build"
    )
    
    parser.add_argument(
        "--debug",
        action="store_true",
        help="Enable debug mode"
    )
    
    parser.add_argument(
        "--output-dir",
        default="dist",
        help="Output directory for built files"
    )
    
    args = parser.parse_args()
    
    # Create build manager and execute build
    build_manager = BuildManager(
        platform=args.platform,
        debug=args.debug,
        output_dir=args.output_dir
    )
    
    success = build_manager.build()
    return 0 if success else 1

if __name__ == "__main__":
    sys.exit(main())
