//
//  TGRouter.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/25.
//

import Foundation

public struct TGRouterKeys {
    public static var roulerURL = "TGRouterKeys_roulerURL"
    public static let animated = "animated"
}

class TGRouter: NSObject {
    
    enum state: Int {
        case loading
        case completed
    }
    //    struct keys {
    //        public static let animated = "animated"
    //    }
    //
    /// 单例实例
    fileprivate static let _shareInstance = TGRouter()
    var mapper: NSMutableDictionary = NSMutableDictionary.init()
    /// 获取单例
    /// - Returns: 单例
    static func shareInstance() -> TGRouter{
        return _shareInstance
    }
    
    func loadConfig(config: NSDictionary? = nil) -> TGRouter {
        return self
    }
    func loadConfig(jsonPath: String?, bundle: Bundle = Bundle.main) -> Void {
        
    }
    func loadConfig(jsonName: String? = "tgrouter", bundle: Bundle = Bundle.main) -> Void {
        
    }
    func loadConfig(plistPath: String?, bundle: Bundle = Bundle.main) -> Void {
            
    }
    func loadConfig(plistName: String? = "tgrouter", bundle: Bundle = Bundle.main) -> Void {
        
    }
    
    func registerRoute(path: String, in any: Any) -> Bool{
        var result: Bool = false;
        result = true;
        self.mapper[path] = any
        return result
    }
    func registerRoute(path: String?,anyClass:  AnyClass) -> Bool{
        if (path?.count ?? 0 < 1) {
            return self.registerRoute(path: NSStringFromClass(anyClass), in: anyClass)
        }
        else {
            return self.registerRoute(path: path!, in: anyClass)
        }
    }
    func registerRoute(anyClass:  AnyClass) -> Bool{
        return self.registerRoute(path: NSStringFromClass(anyClass), anyClass: anyClass)
    }
    func registerRoute(path: String?, classPath: String) -> Bool{
        var result: Bool = false;
        result = true;
        
        return result
    }
    
    open class func open(_ path:UIViewControllerTGRouterProtocol , present: Bool = false , animated: Bool = true , presentComplete: (()->Void)? = nil){
        if let cls = path.classForCoder as? UIViewControllerTGRouterProtocol.Type {
            let vc = cls.initWithParams()
            vc.hidesBottomBarWhenPushed = true
////            let topViewController = TGRouterUtils.currentTopViewController()
//            if topViewController?.navigationController != nil && !present {
//                topViewController?.navigationController?.pushViewController(vc, animated: animated)
//            }else{
//                topViewController?.present(vc, animated: animated , completion: presentComplete)
//            }
        }
    }
    
    func tg_open(urlString: String?) -> Bool{
        return false
    }
    
    class func tg_open(urlString: String?) -> Bool{
        return self.shareInstance().tg_open(urlString: urlString)
    }
    
}
