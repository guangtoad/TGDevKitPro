//
//  UIViewController+TG.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/3/23.
//  UIViewController 一些扩展

import Foundation
import UIKit

/// 视图控制器扩展 增加提示窗口
extension UIViewController{
    /// 创建 Alert Action
    /// - Parameters:
    ///   - title: 标题
    ///   - style: 样式
    ///   - handler: 处理
    /// - Returns: Alert Action
    func createAlertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) -> AlertAction{
        return AlertAction.init(title: title, style: style,handler: handler)
    }
    /// 创建Alert Controller
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - preferredStyle: 样式
    /// - Returns: Alert Controller
    func createAlertController(title: String?, message: String?, preferredStyle: UIAlertController.Style) -> AlertController {
        return AlertController.init(title: title, message: message, preferredStyle:preferredStyle)
    }
    /// 显示提示框
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - handler: 确定按钮动作
    ///   - style: 样式
    /// - Returns:
    func showAlert(title:String = "提示", message:String,style: UIAlertController.Style = UIAlertController.Style.alert, handler:  ((UIAlertAction) -> Void)? = nil ) -> Void{
        let alertController = self.createAlertController(title: title, message:
                                                            message, preferredStyle: .alert)
        if (nil != handler){
            let action = self.createAlertAction(title: "确定", style: .cancel)
            alertController.addAction(action);
        }
        let cancel = self.createAlertAction(title: "取消", style: .cancel)
        alertController.addAction(cancel);
        self.present(alertController, animated: true)
    }
}

extension UIViewController{
    /// 关闭或返回上一页
    /// - Parameter animated: 动画
    /// - Returns: 视图控制器
    func tg_goBack(animated: Bool = true) -> UIViewController? {
        var viewController: UIViewController? = nil
        viewController = self.navigationController?.popViewController(animated: animated)
        if (nil != viewController) {
            return viewController
        }
        self.dismiss(animated: animated)
        return viewController
    }
}
