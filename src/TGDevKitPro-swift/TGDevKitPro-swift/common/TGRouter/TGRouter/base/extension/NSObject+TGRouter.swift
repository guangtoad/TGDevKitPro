//
//  NSObject+TGRoule.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/20.
//

import Foundation

extension NSObject{
    /// 初始化
    /// - Parameter parmasFormat: 参数
    func initWithParams(parmasFormat: NSDictionary){
        
    }
    var tg_roulerLink: String? {
        get {
            return objc_getAssociatedObject(self, &TGRouterKeys.roulerURL) as? String
        }
        set {
            objc_setAssociatedObject(self, &TGRouterKeys.roulerURL, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    func abc(valueString: String?, defValue: Bool = false) -> Bool {
        if (nil == valueString) {
            return defValue
        }
        return false
    }
//    func tg_open(scheme: String?, host: String?, port: Int?, path: String?, queryItems: [URLQueryItem]?) -> Bool {
//        return false
//    }
//
//    func tg_open(_ components: URLComponents?) -> Bool {
//        return false
//    }
//
//    func tg_open(_ url: NSURL) -> Bool {
//        return false
//    }
//
//    func tg_open(_ url: URL) -> Bool {
//        return false
//    }
//
//    func tg_open(_ urlString: String) -> Bool {
//        return false
//    }
    
}
