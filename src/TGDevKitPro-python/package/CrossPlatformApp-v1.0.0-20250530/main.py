#!/usr/bin/env python3
"""
Main entry point for the Python Cross-Platform Application Template.

This template demonstrates how to create a Python application that can be
compiled into standalone executables for Windows and macOS using PyInstaller.
"""

import sys
import os
import argparse
import logging
from pathlib import Path

# Add src directory to Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

from src.app import CrossPlatformApp
from config.app_config import AppConfig

def setup_logging(log_level: str = "INFO") -> None:
    """Setup logging configuration."""
    log_format = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    logging.basicConfig(
        level=getattr(logging, log_level.upper()),
        format=log_format,
        handlers=[
            logging.StreamHandler(sys.stdout),
            logging.FileHandler("app.log", mode='a')
        ]
    )

def parse_arguments() -> argparse.Namespace:
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(
        description="Cross-Platform Python Application Template",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python main.py --gui                 # Run with GUI interface
  python main.py --cli --input file.txt  # Run CLI with input file
  python main.py --version            # Show version information
        """
    )
    
    parser.add_argument(
        "--gui", 
        action="store_true", 
        help="Launch GUI interface"
    )
    
    parser.add_argument(
        "--cli", 
        action="store_true", 
        help="Run in command-line interface mode"
    )
    
    parser.add_argument(
        "--input", 
        type=str, 
        help="Input file path (for CLI mode)"
    )
    
    parser.add_argument(
        "--output", 
        type=str, 
        help="Output file path (for CLI mode)"
    )
    
    parser.add_argument(
        "--log-level", 
        choices=["DEBUG", "INFO", "WARNING", "ERROR"], 
        default="INFO",
        help="Set logging level"
    )
    
    parser.add_argument(
        "--version", 
        action="store_true", 
        help="Show version information"
    )
    
    parser.add_argument(
        "--config", 
        type=str, 
        help="Path to configuration file"
    )
    
    return parser.parse_args()

def main() -> int:
    """Main application entry point."""
    try:
        args = parse_arguments()
        
        # Setup logging
        setup_logging(args.log_level)
        logger = logging.getLogger(__name__)
        
        # Show version if requested
        if args.version:
            config = AppConfig()
            print(f"{config.APP_NAME} v{config.VERSION}")
            print(f"Python {sys.version}")
            print(f"Platform: {sys.platform}")
            return 0
        
        # Initialize application
        logger.info("Starting Cross-Platform Python Application")
        app = CrossPlatformApp(config_path=args.config)
        
        # Determine run mode
        if args.gui:
            logger.info("Launching GUI interface")
            return app.run_gui()
        elif args.cli:
            logger.info("Running in CLI mode")
            return app.run_cli(
                input_file=args.input,
                output_file=args.output
            )
        else:
            # Default to GUI if available, otherwise CLI
            try:
                logger.info("Attempting to launch GUI interface")
                return app.run_gui()
            except ImportError as e:
                logger.warning(f"GUI not available: {e}")
                logger.info("Falling back to CLI mode")
                return app.run_cli()
                
    except KeyboardInterrupt:
        print("\nApplication interrupted by user")
        return 130
    except Exception as e:
        logging.error(f"Unexpected error: {e}", exc_info=True)
        return 1

if __name__ == "__main__":
    sys.exit(main())
