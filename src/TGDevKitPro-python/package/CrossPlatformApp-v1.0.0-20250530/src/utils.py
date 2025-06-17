"""
Utility functions and classes for the cross-platform application.
"""

import os
import sys
import platform
import shutil
from pathlib import Path
from typing import Dict, Any, Optional
import logging

class SystemInfo:
    """Provides system information and platform detection."""
    
    def __init__(self):
        self.logger = logging.getLogger(__name__ + ".SystemInfo")
    
    def get_platform(self) -> str:
        """Get the current platform name."""
        return platform.system()
    
    def get_platform_details(self) -> Dict[str, str]:
        """Get detailed platform information."""
        return {
            'system': platform.system(),
            'release': platform.release(),
            'version': platform.version(),
            'machine': platform.machine(),
            'processor': platform.processor(),
            'architecture': ' '.join(platform.architecture()),
        }
    
    def get_python_info(self) -> Dict[str, str]:
        """Get Python interpreter information."""
        return {
            'version': platform.python_version(),
            'implementation': platform.python_implementation(),
            'compiler': platform.python_compiler(),
            'executable': sys.executable,
        }
    
    def get_app_version(self) -> str:
        """Get application version from version.txt file."""
        try:
            version_file = Path(__file__).parent.parent / "version.txt"
            with open(version_file, 'r') as f:
                return f.read().strip()
        except FileNotFoundError:
            return "1.0.0"
    
    def get_system_info(self) -> Dict[str, Any]:
        """Get comprehensive system information."""
        info = {}
        
        # Basic info
        info.update({
            'Platform': self.get_platform(),
            'Python Version': platform.python_version(),
            'App Version': self.get_app_version(),
        })
        
        # Platform details
        platform_details = self.get_platform_details()
        info.update({
            'OS Release': platform_details['release'],
            'Architecture': platform_details['architecture'],
        })
        
        return info
    
    def is_windows(self) -> bool:
        """Check if running on Windows."""
        return platform.system().lower() == 'windows'
    
    def is_macos(self) -> bool:
        """Check if running on macOS."""
        return platform.system().lower() == 'darwin'
    
    def is_linux(self) -> bool:
        """Check if running on Linux."""
        return platform.system().lower() == 'linux'

class FileProcessor:
    """Handles file processing operations."""
    
    def __init__(self):
        self.logger = logging.getLogger(__name__ + ".FileProcessor")
    
    def process_file(self, input_file: str, output_file: str) -> Dict[str, Any]:
        """
        Process a file and save the result.
        
        This is a template method that demonstrates file processing.
        Replace this with your actual file processing logic.
        """
        self.logger.info(f"Processing file: {input_file} -> {output_file}")
        
        # Validate input file
        if not os.path.exists(input_file):
            raise FileNotFoundError(f"Input file not found: {input_file}")
        
        # Create output directory if it doesn't exist
        output_path = Path(output_file)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        try:
            # Read input file
            with open(input_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Process content (example: add line numbers and word count)
            lines = content.splitlines()
            processed_lines = []
            
            for i, line in enumerate(lines, 1):
                processed_lines.append(f"{i:4d}: {line}")
            
            # Add statistics
            stats = self._calculate_stats(content)
            processed_lines.append("\n" + "=" * 50)
            processed_lines.append("FILE STATISTICS")
            processed_lines.append("=" * 50)
            
            for key, value in stats.items():
                processed_lines.append(f"{key}: {value}")
            
            # Write output file
            processed_content = '\n'.join(processed_lines)
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(processed_content)
            
            self.logger.info(f"File processed successfully: {output_file}")
            
            return {
                'input_file': input_file,
                'output_file': output_file,
                'input_size': len(content),
                'output_size': len(processed_content),
                'lines_processed': len(lines),
                'stats': stats
            }
            
        except Exception as e:
            self.logger.error(f"Error processing file: {e}", exc_info=True)
            raise
    
    def _calculate_stats(self, content: str) -> Dict[str, int]:
        """Calculate statistics for the content."""
        lines = content.splitlines()
        words = content.split()
        characters = len(content)
        characters_no_spaces = len(content.replace(' ', '').replace('\t', '').replace('\n', ''))
        
        return {
            'Lines': len(lines),
            'Words': len(words),
            'Characters (with spaces)': characters,
            'Characters (no spaces)': characters_no_spaces,
        }
    
    def validate_file_path(self, file_path: str) -> bool:
        """Validate if a file path is valid and accessible."""
        try:
            path = Path(file_path)
            
            # Check if parent directory exists or can be created
            if not path.parent.exists():
                try:
                    path.parent.mkdir(parents=True, exist_ok=True)
                except OSError:
                    return False
            
            # Check if we can write to the location
            return os.access(path.parent, os.W_OK)
            
        except Exception:
            return False

class PathUtils:
    """Utility functions for cross-platform path handling."""
    
    @staticmethod
    def normalize_path(path: str) -> str:
        """Normalize a path for the current platform."""
        return str(Path(path).resolve())
    
    @staticmethod
    def ensure_directory(directory: str) -> None:
        """Ensure a directory exists, creating it if necessary."""
        Path(directory).mkdir(parents=True, exist_ok=True)
    
    @staticmethod
    def safe_filename(filename: str) -> str:
        """Generate a safe filename by removing invalid characters."""
        # Characters that are invalid in filenames on various platforms
        invalid_chars = '<>:"/\\|?*'
        safe_name = ''.join(c for c in filename if c not in invalid_chars)
        
        # Replace spaces with underscores (optional)
        safe_name = safe_name.replace(' ', '_')
        
        # Ensure filename is not empty
        if not safe_name:
            safe_name = 'untitled'
        
        return safe_name
    
    @staticmethod
    def get_file_size_string(file_path: str) -> str:
        """Get human-readable file size string."""
        try:
            size = os.path.getsize(file_path)
            
            # Convert to human-readable format
            for unit in ['B', 'KB', 'MB', 'GB']:
                if size < 1024.0:
                    return f"{size:.1f} {unit}"
                size /= 1024.0
            
            return f"{size:.1f} TB"
            
        except OSError:
            return "Unknown"

class ConfigManager:
    """Manages application configuration."""
    
    def __init__(self, config_file: str = "app.ini"):
        self.config_file = config_file
        self.logger = logging.getLogger(__name__ + ".ConfigManager")
    
    def load_config(self) -> Dict[str, Any]:
        """Load configuration from file."""
        # This would implement actual configuration loading
        # For now, return default configuration
        return {
            'debug': False,
            'log_level': 'INFO',
            'auto_save': True,
            'theme': 'default'
        }
    
    def save_config(self, config: Dict[str, Any]) -> None:
        """Save configuration to file."""
        # This would implement actual configuration saving
        self.logger.info(f"Configuration saved to {self.config_file}")
