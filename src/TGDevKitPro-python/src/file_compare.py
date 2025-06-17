"""
Beyond Compare integration for folder comparison and HTML report generation.
"""

import os
import sys
import subprocess
import logging
from pathlib import Path
from typing import Optional, Dict, Any
from datetime import datetime

class BeyondCompareManager:
    """Manages Beyond Compare operations for folder comparison."""
    
    def __init__(self):
        self.logger = logging.getLogger(__name__ + ".BeyondCompareManager")
        self.bc_path = self._find_beyond_compare()
    
    def _find_beyond_compare(self) -> Optional[str]:
        """Find Beyond Compare installation path."""
        possible_paths = []
        
        if sys.platform.startswith('win'):
            # Windows paths
            possible_paths = [
                r"C:\Program Files\Beyond Compare 4\BCompare.exe",
                r"C:\Program Files (x86)\Beyond Compare 4\BCompare.exe",
                r"C:\Program Files\Beyond Compare 5\BCompare.exe",
                r"C:\Program Files (x86)\Beyond Compare 5\BCompare.exe",
            ]
        elif sys.platform == 'darwin':
            # macOS paths
            possible_paths = [
                "/Applications/Beyond Compare.app/Contents/MacOS/bcomp",
                "/usr/local/bin/bcomp",
            ]
        else:
            # Linux paths
            possible_paths = [
                "/usr/bin/bcompare",
                "/usr/local/bin/bcompare",
                "/opt/beyondcompare/bin/bcompare",
            ]
        
        # Check each possible path
        for path in possible_paths:
            if os.path.exists(path):
                self.logger.info(f"Found Beyond Compare at: {path}")
                return path
        
        # Try to find in PATH
        try:
            if sys.platform.startswith('win'):
                result = subprocess.run(['where', 'BCompare'], 
                                      capture_output=True, text=True, check=True)
            else:
                result = subprocess.run(['which', 'bcompare'], 
                                      capture_output=True, text=True, check=True)
            path = result.stdout.strip()
            if path:
                self.logger.info(f"Found Beyond Compare in PATH: {path}")
                return path
        except subprocess.CalledProcessError:
            pass
        
        self.logger.warning("Beyond Compare not found")
        return None
    
    def is_available(self) -> bool:
        """Check if Beyond Compare is available."""
        return self.bc_path is not None
    
    def compare_folders(self, folder1: str, folder2: str, 
                       report_path: str, include_identical: bool = False) -> Dict[str, Any]:
        """
        Compare two folders using Beyond Compare and generate HTML report.
        
        Args:
            folder1: Path to first folder
            folder2: Path to second folder
            report_path: Path for HTML report output
            include_identical: Whether to include identical files in report
            
        Returns:
            Dictionary with comparison results
        """
        if not self.is_available():
            raise RuntimeError("Beyond Compare is not installed or not found")
        
        if not os.path.exists(folder1):
            raise FileNotFoundError(f"Folder 1 not found: {folder1}")
        
        if not os.path.exists(folder2):
            raise FileNotFoundError(f"Folder 2 not found: {folder2}")
        
        # Ensure report directory exists
        report_dir = Path(report_path).parent
        report_dir.mkdir(parents=True, exist_ok=True)
        
        self.logger.info(f"Comparing folders: {folder1} vs {folder2}")
        
        try:
            # Build Beyond Compare command
            cmd = [
                self.bc_path,
                folder1,
                folder2,
                "/report", report_path,
                "/reportformat", "html-details",
                "/leftreadonly",
                "/rightreadonly"
            ]
            
            if not include_identical:
                cmd.append("/excludematches")
            
            # Execute comparison
            self.logger.debug(f"Running command: {' '.join(str(c) for c in cmd)}")
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=300  # 5 minute timeout
            )
            
            # Parse results
            comparison_result = {
                'success': result.returncode in [0, 1],  # 0=identical, 1=differences
                'return_code': result.returncode,
                'report_path': report_path,
                'folder1': folder1,
                'folder2': folder2,
                'timestamp': datetime.now().isoformat(),
                'identical': result.returncode == 0,
                'has_differences': result.returncode == 1,
                'stdout': result.stdout,
                'stderr': result.stderr
            }
            
            if comparison_result['success']:
                self.logger.info("Folder comparison completed successfully")
                
                # Enhance HTML report
                self._enhance_html_report(report_path, comparison_result)
                
                # Get additional statistics
                stats = self._analyze_report(report_path)
                comparison_result.update(stats)
            else:
                self.logger.error(f"Beyond Compare failed with return code: {result.returncode}")
                self.logger.error(f"Error output: {result.stderr}")
            
            return comparison_result
            
        except subprocess.TimeoutExpired:
            raise RuntimeError("Beyond Compare comparison timed out")
        except Exception as e:
            self.logger.error(f"Error during folder comparison: {e}")
            raise
    
    def _enhance_html_report(self, report_path: str, comparison_data: Dict[str, Any]) -> None:
        """Enhance the HTML report with additional information."""
        try:
            if not os.path.exists(report_path):
                return
            
            # Read original report
            with open(report_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Add custom CSS and JavaScript
            custom_header = f"""
            <style>
                .custom-header {{
                    background-color: #f8f9fa;
                    padding: 20px;
                    border-radius: 5px;
                    margin-bottom: 20px;
                    border-left: 4px solid #007bff;
                }}
                .comparison-summary {{
                    display: flex;
                    justify-content: space-between;
                    flex-wrap: wrap;
                    gap: 10px;
                }}
                .summary-item {{
                    background: white;
                    padding: 10px;
                    border-radius: 3px;
                    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                    min-width: 150px;
                }}
                .summary-label {{
                    font-weight: bold;
                    color: #666;
                    font-size: 0.9em;
                }}
                .summary-value {{
                    font-size: 1.2em;
                    margin-top: 5px;
                }}
                .identical {{ color: #28a745; }}
                .different {{ color: #dc3545; }}
                .new {{ color: #17a2b8; }}
            </style>
            
            <div class="custom-header">
                <h2>文件夹比较报告</h2>
                <div class="comparison-summary">
                    <div class="summary-item">
                        <div class="summary-label">比较时间</div>
                        <div class="summary-value">{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</div>
                    </div>
                    <div class="summary-item">
                        <div class="summary-label">左侧文件夹</div>
                        <div class="summary-value">{os.path.basename(comparison_data['folder1'])}</div>
                    </div>
                    <div class="summary-item">
                        <div class="summary-label">右侧文件夹</div>
                        <div class="summary-value">{os.path.basename(comparison_data['folder2'])}</div>
                    </div>
                    <div class="summary-item">
                        <div class="summary-label">比较结果</div>
                        <div class="summary-value {'identical' if comparison_data['identical'] else 'different'}">
                            {'完全相同' if comparison_data['identical'] else '存在差异'}
                        </div>
                    </div>
                </div>
            </div>
            """
            
            # Insert custom header after <body> tag
            if '<body>' in content:
                content = content.replace('<body>', f'<body>{custom_header}')
            
            # Write enhanced report
            with open(report_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            self.logger.debug("HTML report enhanced successfully")
            
        except Exception as e:
            self.logger.warning(f"Failed to enhance HTML report: {e}")
    
    def _analyze_report(self, report_path: str) -> Dict[str, Any]:
        """Analyze the generated HTML report for statistics."""
        stats = {
            'total_files': 0,
            'identical_files': 0,
            'different_files': 0,
            'new_files_left': 0,
            'new_files_right': 0,
            'report_size': 0
        }
        
        try:
            if os.path.exists(report_path):
                stats['report_size'] = os.path.getsize(report_path)
                
                # Basic analysis by reading the HTML content
                with open(report_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Count different types of entries (simplified analysis)
                stats['total_files'] = content.count('<tr>')
                
        except Exception as e:
            self.logger.warning(f"Failed to analyze report: {e}")
        
        return stats
    
    def get_installation_info(self) -> Dict[str, Any]:
        """Get Beyond Compare installation information."""
        info = {
            'installed': self.is_available(),
            'path': self.bc_path,
            'version': None,
            'platform': sys.platform
        }
        
        if self.is_available():
            try:
                # Try to get version information
                result = subprocess.run(
                    [self.bc_path, '/help'],
                    capture_output=True,
                    text=True,
                    timeout=10
                )
                if result.stdout:
                    # Extract version from help output
                    lines = result.stdout.split('\n')
                    for line in lines:
                        if 'Beyond Compare' in line or 'version' in line.lower():
                            info['version'] = line.strip()
                            break
            except Exception as e:
                self.logger.debug(f"Could not get version info: {e}")
        
        return info