//
//  NSObject+TG.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/3/23.
//

import Foundation

private var key_requestAppender: Void?
private var key_requestUrl: Void?

@IBDesignable extension NSObject{
    
    /// 请求地址
    @IBInspectable var requestUrl : NSString?{
        get {
            return objc_getAssociatedObject(self, &key_requestUrl) as? NSString
        }
        set {
            objc_setAssociatedObject(self, &key_requestUrl, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    /// 请求
    /// - Returns: 返回结果
    func request() -> Void {
        return
    }
    
    /// 请求代理
    weak var requestAppender: TGRequestAppender?{
        get {
            return objc_getAssociatedObject(self, &key_requestAppender) as? TGRequestAppender
        }
        set {
            objc_setAssociatedObject(self, &key_requestAppender, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}
