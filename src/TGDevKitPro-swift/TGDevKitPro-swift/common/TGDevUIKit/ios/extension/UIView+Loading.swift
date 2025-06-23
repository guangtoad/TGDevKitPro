//
//  UIView+Loading.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/7.
//

import UIKit


extension UIView {
    
    func loadingView()->UIView?{
        return nil;
    }
    
    func beginLoading(){
        
    }
    
    func endLoading(){
//        var anyClass: AnyClass? = NSClassFromString("asd")
        let obj : NSObject
        obj = NSObject.init()
        
        if (obj.isKind(of: UIViewController.self)) {
            
        }
    }
    /// 获取所在的Controller
    /// - Returns: View Controller
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    /// 显示提示
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - style: 样式
    ///   - handler: 处理
    /// - Returns: 是否可以显示
    func showAlert(title:String = "提示", message:String,style: UIAlertController.Style = UIAlertController.Style.alert, handler:  ((UIAlertAction) -> Void)? = nil ) -> Void {
        self.endEditing(true)
        let viewController = self.firstViewController()
        viewController?.showAlert(title: title, message: message, style: style, handler: handler)
    }
    
}
