"""
Main application module containing the core application logic.
"""

import os
import sys
import logging
from pathlib import Path
from typing import Optional

try:
    import tkinter as tk
    from tkinter import ttk, filedialog, messagebox
    GUI_AVAILABLE = True
except ImportError:
    GUI_AVAILABLE = False

from .utils import FileProcessor, SystemInfo
from .file_compare import BeyondCompareManager

class CrossPlatformApp:
    """Main application class that handles both GUI and CLI interfaces."""
    
    def __init__(self, config_path: Optional[str] = None):
        """Initialize the application."""
        self.logger = logging.getLogger(__name__)
        self.file_processor = FileProcessor()
        self.system_info = SystemInfo()
        self.bc_manager = BeyondCompareManager()
        
        # Load configuration if provided
        if config_path:
            self.load_config(config_path)
    
    def load_config(self, config_path: str) -> None:
        """Load configuration from file."""
        if os.path.exists(config_path):
            self.logger.info(f"Loading configuration from {config_path}")
            # Configuration loading logic would go here
        else:
            self.logger.warning(f"Configuration file not found: {config_path}")
    
    def run_gui(self) -> int:
        """Run the application with GUI interface."""
        if not GUI_AVAILABLE:
            raise ImportError("GUI dependencies not available")
        
        self.logger.info("Starting GUI interface")
        
        try:
            app = GuiApplication(self)
            app.run()
            return 0
        except Exception as e:
            self.logger.error(f"GUI error: {e}", exc_info=True)
            return 1
    
    def run_cli(self, input_file: Optional[str] = None, output_file: Optional[str] = None) -> int:
        """Run the application in CLI mode."""
        self.logger.info("Starting CLI interface")
        
        try:
            cli = CliApplication(self)
            return cli.run(input_file=input_file, output_file=output_file)
        except Exception as e:
            self.logger.error(f"CLI error: {e}", exc_info=True)
            return 1

class GuiApplication:
    """GUI application interface using tkinter."""
    
    def __init__(self, app: CrossPlatformApp):
        self.app = app
        self.logger = logging.getLogger(__name__ + ".GUI")
        self.root = None
        self.setup_gui()
    
    def setup_gui(self) -> None:
        """Setup the GUI interface."""
        self.root = tk.Tk()
        self.root.title(f"Cross-Platform App v{self.app.system_info.get_app_version()}")
        
        # Set a much larger window size to accommodate all content
        self.root.geometry("1200x800")
        self.root.minsize(900, 700)  # Minimum window size
        
        # Make window resizable
        self.root.resizable(True, True)
        
        # Center the window
        self.center_window()
        
        # Create main interface
        self.create_widgets()
        
        # Setup menu
        self.create_menu()
        
        # Bind events
        self.root.protocol("WM_DELETE_WINDOW", self.on_closing)
    
    def center_window(self) -> None:
        """Center the window on the screen."""
        self.root.withdraw()  # Hide window while calculating
        self.root.update_idletasks()
        
        # Use the larger window size
        width = 1200
        height = 800
        
        screen_width = self.root.winfo_screenwidth()
        screen_height = self.root.winfo_screenheight()
        
        x = max(0, (screen_width // 2) - (width // 2))
        y = max(0, (screen_height // 2) - (height // 2))
        
        self.root.geometry(f"{width}x{height}+{x}+{y}")
        self.root.deiconify()  # Show window
    
    def create_widgets(self) -> None:
        """Create the main GUI widgets."""
        # Main frame
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Configure grid weights
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(0, weight=1)
        main_frame.rowconfigure(1, weight=1)
        
        # Title
        title_label = ttk.Label(
            main_frame,
            text="Cross-Platform Python Application",
            font=("Arial", 18, "bold")
        )
        title_label.grid(row=0, column=0, pady=(0, 20))
        
        # Create notebook for different function modules
        self.notebook = ttk.Notebook(main_frame)
        self.notebook.grid(row=1, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Create different tabs
        self.create_system_info_tab()
        self.create_file_processing_tab()
        self.create_tools_tab()
        self.create_settings_tab()
    
    def create_system_info_tab(self) -> None:
        """Create system information tab."""
        info_frame = ttk.Frame(self.notebook, padding="20")
        self.notebook.add(info_frame, text="系统信息")
        
        # System information display
        system_frame = ttk.LabelFrame(info_frame, text="System Information", padding="15")
        system_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), pady=(0, 15))
        system_frame.columnconfigure(1, weight=1)
        
        # Display system info
        system_info = self.app.system_info.get_system_info()
        row = 0
        for key, value in system_info.items():
            ttk.Label(system_frame, text=f"{key}:", font=("Arial", 10, "bold")).grid(
                row=row, column=0, sticky=tk.W, padx=(0, 15), pady=5
            )
            ttk.Label(system_frame, text=str(value)).grid(
                row=row, column=1, sticky=tk.W, pady=5
            )
            row += 1
        
        # Platform details
        details_frame = ttk.LabelFrame(info_frame, text="Platform Details", padding="15")
        details_frame.grid(row=1, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), pady=(0, 15))
        details_frame.columnconfigure(1, weight=1)
        
        platform_details = self.app.system_info.get_platform_details()
        row = 0
        for key, value in platform_details.items():
            ttk.Label(details_frame, text=f"{key.title()}:", font=("Arial", 10, "bold")).grid(
                row=row, column=0, sticky=tk.W, padx=(0, 15), pady=5
            )
            ttk.Label(details_frame, text=str(value)).grid(
                row=row, column=1, sticky=tk.W, pady=5
            )
            row += 1
        
        # Configure grid weights
        info_frame.columnconfigure(0, weight=1)
        info_frame.rowconfigure(0, weight=1)
        info_frame.rowconfigure(1, weight=1)
    
    def create_file_processing_tab(self) -> None:
        """Create file processing tab."""
        file_frame = ttk.Frame(self.notebook, padding="20")
        self.notebook.add(file_frame, text="文件处理")
        
        # File selection section
        selection_frame = ttk.LabelFrame(file_frame, text="File Selection", padding="15")
        selection_frame.grid(row=0, column=0, sticky=(tk.W, tk.E), pady=(0, 15))
        selection_frame.columnconfigure(1, weight=1)
        
        # Input file selection
        ttk.Label(selection_frame, text="输入文件:", font=("Arial", 10, "bold")).grid(
            row=0, column=0, sticky=tk.W, padx=(0, 10), pady=5
        )
        self.input_file_var = tk.StringVar()
        ttk.Entry(selection_frame, textvariable=self.input_file_var, width=50).grid(
            row=0, column=1, sticky=(tk.W, tk.E), padx=(0, 10), pady=5
        )
        ttk.Button(selection_frame, text="浏览", command=self.browse_input_file).grid(
            row=0, column=2, pady=5
        )
        
        # Output file selection
        ttk.Label(selection_frame, text="输出文件:", font=("Arial", 10, "bold")).grid(
            row=1, column=0, sticky=tk.W, padx=(0, 10), pady=5
        )
        self.output_file_var = tk.StringVar()
        ttk.Entry(selection_frame, textvariable=self.output_file_var, width=50).grid(
            row=1, column=1, sticky=(tk.W, tk.E), padx=(0, 10), pady=5
        )
        ttk.Button(selection_frame, text="保存为", command=self.browse_output_file).grid(
            row=1, column=2, pady=5
        )
        
        # Process controls
        controls_frame = ttk.LabelFrame(file_frame, text="Processing Controls", padding="15")
        controls_frame.grid(row=1, column=0, sticky=(tk.W, tk.E), pady=(0, 15))
        
        # Process button
        process_btn = ttk.Button(
            controls_frame, 
            text="开始处理文件", 
            command=self.process_file,
            style="Accent.TButton"
        )
        process_btn.grid(row=0, column=0, pady=10)
        
        # Clear button
        clear_btn = ttk.Button(
            controls_frame, 
            text="清空输出", 
            command=self.clear_output
        )
        clear_btn.grid(row=0, column=1, padx=(10, 0), pady=10)
        
        # Output area
        output_frame = ttk.LabelFrame(file_frame, text="Output Log", padding="15")
        output_frame.grid(row=2, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), pady=(0, 15))
        output_frame.columnconfigure(0, weight=1)
        output_frame.rowconfigure(0, weight=1)
        
        # Text widget with scrollbar
        self.output_text = tk.Text(output_frame, wrap=tk.WORD, height=12, font=("Consolas", 9))
        scrollbar = ttk.Scrollbar(output_frame, orient=tk.VERTICAL, command=self.output_text.yview)
        self.output_text.configure(yscrollcommand=scrollbar.set)
        
        self.output_text.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        scrollbar.grid(row=0, column=1, sticky=(tk.N, tk.S))
        
        # Configure grid weights
        file_frame.columnconfigure(0, weight=1)
        file_frame.rowconfigure(2, weight=1)
    
    def create_tools_tab(self) -> None:
        """Create tools tab."""
        tools_frame = ttk.Frame(self.notebook, padding="20")
        self.notebook.add(tools_frame, text="工具箱")
        
        # Quick actions section
        actions_frame = ttk.LabelFrame(tools_frame, text="Quick Actions", padding="15")
        actions_frame.grid(row=0, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=(0, 15))
        
        # Button grid for tools
        tools_buttons = [
            ("文本转换器", self.open_text_converter),
            ("文件信息", self.show_file_info),
            ("批量重命名", self.batch_rename),
            ("文件比较", self.file_compare),
            ("数据统计", self.data_statistics),
            ("格式转换", self.format_converter)
        ]
        
        for i, (text, command) in enumerate(tools_buttons):
            row = i // 3
            col = i % 3
            btn = ttk.Button(actions_frame, text=text, command=command, width=15)
            btn.grid(row=row, column=col, padx=10, pady=10)
        
        # Utility section
        utility_frame = ttk.LabelFrame(tools_frame, text="Utilities", padding="15")
        utility_frame.grid(row=1, column=0, columnspan=2, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Placeholder for utility content
        ttk.Label(utility_frame, text="实用工具功能区域", font=("Arial", 12)).grid(row=0, column=0, pady=20)
        ttk.Label(utility_frame, text="在这里可以添加更多实用功能", foreground="gray").grid(row=1, column=0)
        
        # Configure grid weights
        tools_frame.columnconfigure(0, weight=1)
        tools_frame.rowconfigure(1, weight=1)
    
    def create_settings_tab(self) -> None:
        """Create settings tab."""
        settings_frame = ttk.Frame(self.notebook, padding="20")
        self.notebook.add(settings_frame, text="设置")
        
        # Application settings
        app_frame = ttk.LabelFrame(settings_frame, text="Application Settings", padding="15")
        app_frame.grid(row=0, column=0, sticky=(tk.W, tk.E), pady=(0, 15))
        app_frame.columnconfigure(1, weight=1)
        
        # Theme selection
        ttk.Label(app_frame, text="主题:", font=("Arial", 10, "bold")).grid(
            row=0, column=0, sticky=tk.W, padx=(0, 10), pady=5
        )
        self.theme_var = tk.StringVar(value="default")
        theme_combo = ttk.Combobox(app_frame, textvariable=self.theme_var, 
                                  values=["default", "dark", "light"], state="readonly")
        theme_combo.grid(row=0, column=1, sticky=tk.W, pady=5)
        
        # Language selection
        ttk.Label(app_frame, text="语言:", font=("Arial", 10, "bold")).grid(
            row=1, column=0, sticky=tk.W, padx=(0, 10), pady=5
        )
        self.language_var = tk.StringVar(value="中文")
        language_combo = ttk.Combobox(app_frame, textvariable=self.language_var,
                                     values=["中文", "English"], state="readonly")
        language_combo.grid(row=1, column=1, sticky=tk.W, pady=5)
        
        # Auto-save option
        self.autosave_var = tk.BooleanVar(value=True)
        autosave_check = ttk.Checkbutton(app_frame, text="自动保存设置", variable=self.autosave_var)
        autosave_check.grid(row=2, column=0, columnspan=2, sticky=tk.W, pady=10)
        
        # About section
        about_frame = ttk.LabelFrame(settings_frame, text="About", padding="15")
        about_frame.grid(row=1, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Application info
        info_text = f"""
应用程序名称: Cross-Platform Python Application
版本: {self.app.system_info.get_app_version()}
平台: {self.app.system_info.get_platform()}

这是一个跨平台Python应用程序模板，
支持Windows和macOS可执行文件生成。
        """
        
        about_label = ttk.Label(about_frame, text=info_text.strip(), justify=tk.LEFT)
        about_label.grid(row=0, column=0, sticky=(tk.W, tk.N))
        
        # Configure grid weights
        settings_frame.columnconfigure(0, weight=1)
        settings_frame.rowconfigure(1, weight=1)
    
    def create_menu(self) -> None:
        """Create the application menu."""
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)
        
        # File menu
        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="Open...", command=self.browse_input_file)
        file_menu.add_command(label="Save As...", command=self.browse_output_file)
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self.on_closing)
        
        # Help menu
        help_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="About", command=self.show_about)
    
    def browse_input_file(self) -> None:
        """Browse for input file."""
        filename = filedialog.askopenfilename(
            title="Select Input File",
            filetypes=[
                ("Text files", "*.txt"),
                ("All files", "*.*")
            ]
        )
        if filename:
            self.input_file_var.set(filename)
    
    def browse_output_file(self) -> None:
        """Browse for output file."""
        filename = filedialog.asksaveasfilename(
            title="Save Output As",
            defaultextension=".txt",
            filetypes=[
                ("Text files", "*.txt"),
                ("All files", "*.*")
            ]
        )
        if filename:
            self.output_file_var.set(filename)
    
    def process_file(self) -> None:
        """Process the selected file."""
        input_file = self.input_file_var.get()
        output_file = self.output_file_var.get()
        
        if not input_file:
            messagebox.showerror("Error", "Please select an input file")
            return
        
        if not output_file:
            messagebox.showerror("Error", "Please specify an output file")
            return
        
        try:
            result = self.app.file_processor.process_file(input_file, output_file)
            self.output_text.insert(tk.END, f"File processed successfully!\n")
            self.output_text.insert(tk.END, f"Input: {input_file}\n")
            self.output_text.insert(tk.END, f"Output: {output_file}\n")
            self.output_text.insert(tk.END, f"Result: {result}\n\n")
            self.output_text.see(tk.END)
            
            messagebox.showinfo("Success", "File processed successfully!")
            
        except Exception as e:
            error_msg = f"Error processing file: {e}"
            self.output_text.insert(tk.END, f"{error_msg}\n\n")
            self.output_text.see(tk.END)
            messagebox.showerror("Error", error_msg)
    
    def show_about(self) -> None:
        """Show about dialog."""
        about_text = f"""Cross-Platform Python Application
Version: {self.app.system_info.get_app_version()}
Platform: {self.app.system_info.get_platform()}

This is a template application demonstrating cross-platform
Python development with PyInstaller build scripts.
"""
        messagebox.showinfo("About", about_text)
    
    def clear_output(self) -> None:
        """Clear the output text area."""
        self.output_text.delete(1.0, tk.END)
        self.output_text.insert(tk.END, "输出已清空\n")
    
    def open_text_converter(self) -> None:
        """Open text converter tool."""
        messagebox.showinfo("工具", "文本转换器功能开发中...")
    
    def show_file_info(self) -> None:
        """Show file information tool."""
        messagebox.showinfo("工具", "文件信息功能开发中...")
    
    def batch_rename(self) -> None:
        """Batch rename tool."""
        messagebox.showinfo("工具", "批量重命名功能开发中...")
    
    def file_compare(self) -> None:
        """File comparison tool using Beyond Compare."""
        self.open_file_compare_window()
    
    def data_statistics(self) -> None:
        """Data statistics tool."""
        messagebox.showinfo("工具", "数据统计功能开发中...")
    
    def format_converter(self) -> None:
        """Format converter tool."""
        messagebox.showinfo("工具", "格式转换功能开发中...")
    
    def open_file_compare_window(self) -> None:
        """Open Beyond Compare file comparison window."""
        compare_window = tk.Toplevel(self.root)
        compare_window.title("文件夹比较工具")
        compare_window.geometry("800x600")
        compare_window.transient(self.root)
        compare_window.grab_set()
        
        # Main frame
        main_frame = ttk.Frame(compare_window, padding="20")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        compare_window.columnconfigure(0, weight=1)
        compare_window.rowconfigure(0, weight=1)
        main_frame.columnconfigure(0, weight=1)
        main_frame.rowconfigure(3, weight=1)
        
        # Title
        title_label = ttk.Label(main_frame, text="Beyond Compare 文件夹比较", 
                               font=("Arial", 14, "bold"))
        title_label.grid(row=0, column=0, pady=(0, 20))
        
        # Check Beyond Compare availability
        bc_info = self.app.bc_manager.get_installation_info()
        if not bc_info['installed']:
            warning_frame = ttk.LabelFrame(main_frame, text="警告", padding="10")
            warning_frame.grid(row=1, column=0, sticky=(tk.W, tk.E), pady=(0, 15))
            
            warning_text = ("未检测到Beyond Compare安装。\n"
                          "请安装Beyond Compare 4或5版本以使用此功能。\n"
                          "下载地址: https://www.scootersoftware.com/")
            ttk.Label(warning_frame, text=warning_text, foreground="red").grid(row=0, column=0)
        
        # Folder selection
        selection_frame = ttk.LabelFrame(main_frame, text="选择比较文件夹", padding="15")
        selection_frame.grid(row=2, column=0, sticky=(tk.W, tk.E), pady=(0, 15))
        selection_frame.columnconfigure(1, weight=1)
        
        # Folder 1
        ttk.Label(selection_frame, text="文件夹1:", font=("Arial", 10, "bold")).grid(
            row=0, column=0, sticky=tk.W, padx=(0, 10), pady=5
        )
        self.folder1_var = tk.StringVar()
        ttk.Entry(selection_frame, textvariable=self.folder1_var, width=60).grid(
            row=0, column=1, sticky=(tk.W, tk.E), padx=(0, 10), pady=5
        )
        ttk.Button(selection_frame, text="浏览", 
                  command=self.browse_folder1).grid(row=0, column=2, pady=5)
        
        # Folder 2
        ttk.Label(selection_frame, text="文件夹2:", font=("Arial", 10, "bold")).grid(
            row=1, column=0, sticky=tk.W, padx=(0, 10), pady=5
        )
        self.folder2_var = tk.StringVar()
        ttk.Entry(selection_frame, textvariable=self.folder2_var, width=60).grid(
            row=1, column=1, sticky=(tk.W, tk.E), padx=(0, 10), pady=5
        )
        ttk.Button(selection_frame, text="浏览", 
                  command=self.browse_folder2).grid(row=1, column=2, pady=5)
        
        # Options
        options_frame = ttk.LabelFrame(main_frame, text="比较选项", padding="15")
        options_frame.grid(row=3, column=0, sticky=(tk.W, tk.E), pady=(0, 15))
        
        self.include_identical_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(options_frame, text="包含相同文件", 
                       variable=self.include_identical_var).grid(row=0, column=0, sticky=tk.W)
        
        # Control buttons
        button_frame = ttk.Frame(main_frame)
        button_frame.grid(row=4, column=0, pady=10)
        
        compare_btn = ttk.Button(button_frame, text="开始比较", 
                               command=self.start_comparison,
                               style="Accent.TButton")
        compare_btn.grid(row=0, column=0, padx=(0, 10))
        
        close_btn = ttk.Button(button_frame, text="关闭", 
                             command=compare_window.destroy)
        close_btn.grid(row=0, column=1)
        
        # Store window reference
        self.compare_window = compare_window
    
    def browse_folder1(self) -> None:
        """Browse for first folder."""
        folder = filedialog.askdirectory(title="选择第一个文件夹")
        if folder:
            self.folder1_var.set(folder)
    
    def browse_folder2(self) -> None:
        """Browse for second folder."""
        folder = filedialog.askdirectory(title="选择第二个文件夹")
        if folder:
            self.folder2_var.set(folder)
    
    def start_comparison(self) -> None:
        """Start Beyond Compare folder comparison."""
        folder1 = self.folder1_var.get().strip()
        folder2 = self.folder2_var.get().strip()
        
        if not folder1 or not folder2:
            messagebox.showerror("错误", "请选择两个要比较的文件夹")
            return
        
        if not os.path.exists(folder1):
            messagebox.showerror("错误", f"文件夹1不存在: {folder1}")
            return
        
        if not os.path.exists(folder2):
            messagebox.showerror("错误", f"文件夹2不存在: {folder2}")
            return
        
        if not self.app.bc_manager.is_available():
            messagebox.showerror("错误", "Beyond Compare未安装或无法找到")
            return
        
        try:
            # Generate report path
            from datetime import datetime
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            report_path = f"./output/compare_report_{timestamp}.html"
            
            # Show progress
            progress_window = self.show_progress_window("正在比较文件夹...")
            self.compare_window.update()
            
            # Perform comparison
            result = self.app.bc_manager.compare_folders(
                folder1, folder2, report_path, 
                include_identical=self.include_identical_var.get()
            )
            
            # Close progress window
            progress_window.destroy()
            
            if result['success']:
                # Show results
                if result['identical']:
                    message = "文件夹完全相同！"
                else:
                    message = f"发现差异！\n报告已生成: {report_path}"
                
                messagebox.showinfo("比较完成", message)
                
                # Ask if user wants to open report
                if messagebox.askyesno("打开报告", "是否要打开HTML比较报告？"):
                    self.open_html_report(report_path)
            else:
                messagebox.showerror("比较失败", f"Beyond Compare执行失败\n错误代码: {result['return_code']}")
        
        except Exception as e:
            if 'progress_window' in locals():
                progress_window.destroy()
            messagebox.showerror("错误", f"比较过程中出现错误: {str(e)}")
    
    def show_progress_window(self, message: str):
        """Show a simple progress window."""
        progress = tk.Toplevel(self.compare_window)
        progress.title("请稍候")
        progress.geometry("300x100")
        progress.transient(self.compare_window)
        progress.grab_set()
        
        # Center the progress window
        progress.geometry("+%d+%d" % (
            self.compare_window.winfo_rootx() + 250,
            self.compare_window.winfo_rooty() + 200
        ))
        
        ttk.Label(progress, text=message, font=("Arial", 11)).pack(expand=True)
        progress.update()
        
        return progress
    
    def open_html_report(self, report_path: str) -> None:
        """Open HTML report in default browser."""
        try:
            import webbrowser
            import os
            full_path = os.path.abspath(report_path)
            webbrowser.open(f"file://{full_path}")
        except Exception as e:
            messagebox.showerror("错误", f"无法打开报告: {str(e)}")
    
    def on_closing(self) -> None:
        """Handle window closing event."""
        self.logger.info("Closing GUI application")
        self.root.destroy()
    
    def run(self) -> None:
        """Run the GUI application."""
        self.logger.info("Starting GUI main loop")
        self.root.mainloop()

class CliApplication:
    """Command-line interface for the application."""
    
    def __init__(self, app: CrossPlatformApp):
        self.app = app
        self.logger = logging.getLogger(__name__ + ".CLI")
    
    def run(self, input_file: Optional[str] = None, output_file: Optional[str] = None) -> int:
        """Run the CLI application."""
        self.logger.info("Starting CLI application")
        
        try:
            # Show welcome message
            self.show_welcome()
            
            # If no input file specified, prompt for it
            if not input_file:
                input_file = self.prompt_for_input_file()
            
            # If no output file specified, generate one
            if not output_file:
                output_file = self.generate_output_filename(input_file)
            
            # Process the file
            if input_file and output_file:
                result = self.app.file_processor.process_file(input_file, output_file)
                print(f"\nFile processed successfully!")
                print(f"Input: {input_file}")
                print(f"Output: {output_file}")
                print(f"Result: {result}")
                return 0
            else:
                print("No input file specified. Exiting.")
                return 1
                
        except KeyboardInterrupt:
            print("\nOperation cancelled by user.")
            return 130
        except Exception as e:
            self.logger.error(f"CLI error: {e}", exc_info=True)
            print(f"Error: {e}")
            return 1
    
    def show_welcome(self) -> None:
        """Show welcome message."""
        print("=" * 50)
        print("Cross-Platform Python Application")
        print(f"Version: {self.app.system_info.get_app_version()}")
        print(f"Platform: {self.app.system_info.get_platform()}")
        print("=" * 50)
    
    def prompt_for_input_file(self) -> Optional[str]:
        """Prompt user for input file."""
        while True:
            input_file = input("\nEnter input file path (or 'quit' to exit): ").strip()
            
            if input_file.lower() == 'quit':
                return None
            
            if not input_file:
                continue
            
            if os.path.exists(input_file):
                return input_file
            else:
                print(f"File not found: {input_file}")
    
    def generate_output_filename(self, input_file: str) -> str:
        """Generate output filename based on input file."""
        input_path = Path(input_file)
        output_path = input_path.parent / f"{input_path.stem}_processed{input_path.suffix}"
        return str(output_path)
