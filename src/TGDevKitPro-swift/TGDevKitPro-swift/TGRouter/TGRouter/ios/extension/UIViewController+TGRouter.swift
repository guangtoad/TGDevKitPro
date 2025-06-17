//
//  UIViewController+TGRouter.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/3/29.
//

import UIKit

/// 扩展视图控制器
extension UIViewController{
    
    func initWithParams(parmasFormat: NSDictionary? = [:]) -> UIViewController{
        return self
    }
    
    func tg_open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:]) -> Bool {
        return false
    }
    
    func tg_asyncopen(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:])  -> Bool {
        return false
    }
    /// 初始化
    /// - Parameter parmasFormat: 参数
    /// - Returns: 初始化
    static public func initWithParams(parmasFormat: NSDictionary? = [:]) -> UIViewController{
        
        var viewController: UIViewController? = nil
        
        let coder: NSCoder? = parmasFormat?.object(forKey: "coder") as? NSCoder
        if (nil != coder) {
            viewController =  self.init(coder: coder!)
        }
        
        let nibName: String? = parmasFormat?.object(forKey: "nibName") as? String
        if (nil != nibName){
            let bundle: Bundle? = parmasFormat?.object(forKey: "bundle") as? Bundle
            viewController = self.init(nibName: nibName, bundle: bundle)
        }
        if (nil == viewController) {
            viewController = self.init()
        }
        
        let storyboardName: String? = parmasFormat?.object(forKey: "storyboardName") as? String
        if (nil != storyboardName){
            let bundle: Bundle? = parmasFormat?.object(forKey: "bundle") as? Bundle
            let storyboard = UIStoryboard(name: storyboardName!, bundle: bundle)
            
            let identifier: String? = parmasFormat?.object(forKey: "identifier") as? String
            if (nil != identifier && identifier!.count > 0){
                viewController = storyboard.instantiateViewController(withIdentifier: identifier!)
            }
            else {
                viewController = storyboard.instantiateInitialViewController()
            }
        }
        if (nil == viewController) {
            viewController = self.init()
        }
        return viewController!
    }
    
}
