"""
Application configuration module.

This module contains all configuration settings for the application,
including version information, paths, and platform-specific settings.
"""

import os
import sys
import configparser
from pathlib import Path
from typing import Dict, Any, Optional

class AppConfig:
    """Application configuration class."""
    
    # Application metadata
    APP_NAME = "CrossPlatformApp"
    APP_DESCRIPTION = "Python Cross-Platform Application Template"
    AUTHOR = "Your Name"
    EMAIL = "your.email@example.com"
    
    # Version information (read from version.txt)
    @property
    def VERSION(self) -> str:
        """Get application version from version.txt file."""
        version_file = Path(__file__).parent.parent / "version.txt"
        try:
            with open(version_file, 'r') as f:
                return f.read().strip()
        except FileNotFoundError:
            return "1.0.0"
    
    # Paths
    BASE_DIR = Path(__file__).parent.parent
    SRC_DIR = BASE_DIR / "src"
    RESOURCES_DIR = BASE_DIR / "resources"
    BUILD_DIR = BASE_DIR / "build"
    DIST_DIR = BASE_DIR / "dist"
    
    # Platform detection
    IS_WINDOWS = sys.platform.startswith('win')
    IS_MACOS = sys.platform == 'darwin'
    IS_LINUX = sys.platform.startswith('linux')
    
    # Platform-specific settings
    if IS_WINDOWS:
        ICON_FILE = RESOURCES_DIR / "icon.ico"
        EXECUTABLE_EXTENSION = ".exe"
    elif IS_MACOS:
        ICON_FILE = RESOURCES_DIR / "icon.icns"
        EXECUTABLE_EXTENSION = ".app"
    else:
        ICON_FILE = None
        EXECUTABLE_EXTENSION = ""
    
    # GUI settings
    GUI_AVAILABLE = True
    try:
        import tkinter
    except ImportError:
        GUI_AVAILABLE = False
    
    # Default configuration
    DEFAULT_CONFIG = {
        'app': {
            'debug': 'false',
            'log_level': 'INFO',
            'auto_save': 'true',
            'theme': 'default'
        },
        'gui': {
            'window_width': '800',
            'window_height': '600',
            'resizable': 'true',
            'center_window': 'true'
        },
        'paths': {
            'default_input_dir': '.',
            'default_output_dir': './output'
        }
    }
    
    def __init__(self, config_path: Optional[str] = None):
        """Initialize configuration with optional custom config file."""
        self.config = configparser.ConfigParser()
        self.config.read_dict(self.DEFAULT_CONFIG)
        
        # Load custom configuration if provided
        if config_path and os.path.exists(config_path):
            self.config.read(config_path)
        
        # Create necessary directories
        self._create_directories()
    
    def _create_directories(self) -> None:
        """Create necessary directories if they don't exist."""
        directories = [
            self.DIST_DIR,
            Path(self.get('paths', 'default_output_dir'))
        ]
        
        for directory in directories:
            Path(directory).mkdir(parents=True, exist_ok=True)
    
    def get(self, section: str, key: str, fallback: Any = None) -> str:
        """Get configuration value."""
        return self.config.get(section, key, fallback=fallback)
    
    def getboolean(self, section: str, key: str, fallback: bool = False) -> bool:
        """Get boolean configuration value."""
        return self.config.getboolean(section, key, fallback=fallback)
    
    def getint(self, section: str, key: str, fallback: int = 0) -> int:
        """Get integer configuration value."""
        return self.config.getint(section, key, fallback=fallback)
    
    def save_config(self, config_path: str) -> None:
        """Save current configuration to file."""
        with open(config_path, 'w') as f:
            self.config.write(f)
    
    def get_build_info(self) -> Dict[str, Any]:
        """Get build information for PyInstaller."""
        return {
            'name': self.APP_NAME,
            'version': self.VERSION,
            'description': self.APP_DESCRIPTION,
            'author': self.AUTHOR,
            'icon': str(self.ICON_FILE) if self.ICON_FILE else None,
            'console': not self.GUI_AVAILABLE,
            'onefile': True,
            'windowed': self.GUI_AVAILABLE and not self.getboolean('app', 'debug')
        }
