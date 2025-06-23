//
//  TGRouterUtils.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/25.
//

import UIKit

public extension UIWindow {
    
    func topMostWindowController()->UIViewController? {
        
        var topController = rootViewController
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        return topController
    }
    
    func currentViewController()->UIViewController? {
        
        var currentViewController = topMostWindowController()
        if currentViewController is UITabBarController{
            currentViewController = (currentViewController as! UITabBarController).selectedViewController
        }
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }
        return currentViewController
    }
}

class TGRouterUtils: NSObject {
    //获取当前页面
    public class func currentTopViewController() -> UIViewController? {
        //      if let rootViewController = UIApplication.shared.keyWindow?.rootViewController{
        //        return currentTopViewController(rootViewCon1troller: rootViewController)
        //      }else{
        //      }
        return nil
    }
    
    public class func currentTopViewController(rootViewController: UIViewController) -> UIViewController {
        if (rootViewController.isKind(of: UITabBarController.self)) {
            let tabBarController = rootViewController as! UITabBarController
            return currentTopViewController(rootViewController: tabBarController.selectedViewController!)
        }
        if (rootViewController.isKind(of: UINavigationController.self)) {
            let navigationController = rootViewController as! UINavigationController
            return currentTopViewController(rootViewController: navigationController.visibleViewController!)
        }
        if ((rootViewController.presentedViewController) != nil) {
            return currentTopViewController(rootViewController: rootViewController.presentedViewController!)
        }
        return rootViewController
    }
    
//    override class func load() {
//        super.load()
//    }
}
