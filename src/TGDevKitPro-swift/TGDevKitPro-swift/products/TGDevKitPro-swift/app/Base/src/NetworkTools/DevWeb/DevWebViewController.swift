//
//  DevWebViewController.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/12.
//

import UIKit
import WebKit

class DevWebViewController: ViewController , WKNavigationDelegate , WKUIDelegate {
    @IBOutlet var webView : WKWebView?
    @IBOutlet weak var menuItem : UIButton?
    
    @IBAction func click_rload(){
        self.webView?.reload()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = WKWebView.init(frame: self.view.bounds)
        self.webView?.navigationDelegate = self
        self.webView?.uiDelegate = self
        self.view.addSubview(self.webView!)
    }
    
    func reloadBaseUrl() -> Void {
        var url = URL.init(string: "")
        var request = URLRequest(url: url!)
        self.webView?.load(request)
    }
    ///
    /// - Returns: 无
    func reloadWebView() -> Void {
        self.webView?.reload()
        self.reloadBaseUrl()
    }
    
    /// 显示日志
    /// - Parameter isHidden: 隐藏
    /// - Returns: 无
    func showLogView(isHidden: Bool) -> Void {
        
    }
    
    // MARK: - View Controller
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView?.frame = self.view.bounds
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination.isKind(of: DevWebViewController.self)){
            self.showAlert(message: "url is null")
            var controller: DevWebViewController = segue.destination as! DevWebViewController
            controller.requestUrl
//            controller.requestUrl = self.textLabel
        }
    }
}
