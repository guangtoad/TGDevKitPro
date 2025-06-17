//
//  TGRouterProtocol.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/3/29.
//

import UIKit

protocol TGRouterProtocol: NSObjectProtocol {
    
    //    var any: AnyClass { get }
    // MARK: -
    
    /// 初始化
    /// - Parameter parmasFormat: 参数
    func initWithParams(parmasFormat: NSDictionary)
    
    // MARK: -
    
    func tg_push(scheme: String?, host: String?, port: Int?, path: String?, parmasFormat: NSDictionary?) -> Bool
    
    func tg_open(scheme: String?, host: String?, port: Int?, path: String?, parmasFormat: NSDictionary?) -> Bool
    func tg_open(scheme: String?, host: String?, port: Int?, path: String?, queryItems: [URLQueryItem]?) -> Bool
    /// 打开地址
    /// - Parameter components: URL Components
    /// - Returns: 执行结果
    func tg_open(_ components: URLComponents?) -> Bool
    /// 打开地址
    /// - Parameter url: 地址 NSURL
    /// - Returns: 执行地址
    func tg_open(_ url: NSURL) -> Bool
    /// 打开地址
    /// - Parameter url: 地址URL
    /// - Returns: 执行结果
    func tg_open(_ url: URL) -> Bool
    /// 打开地址
    /// - Parameter urlString: 地址字符串
    /// - Returns: 执行结果
    func tg_open(urlString: String?) -> Bool
    
    // MARK: -
    func tg_create(scheme: String?, host: String?, port: Int?, path: String?, parmasFormat: NSDictionary?) -> AnyClass?
}

extension TGRouterProtocol {
    // MARK: -
    func tg_create(scheme: String?, host: String?, port: Int?, path: String?, parmasFormat: NSDictionary?) -> AnyClass?{
        var result: AnyClass? = nil
        do {
            let anyClass: AnyClass? = NSClassFromString(host!)
            if (nil == anyClass) {
                throw NSError.init(domain: "class is null", code: 404)
            }
            result = anyClass
        }
        catch{
            result = nil
        }
        return result
    }
    
    // MARK: - 
    
    /// 打开
    /// - Parameters:
    ///   - viewController: 视图控制器
    ///   - animated: 是否显示动画
    ///   - onlyPresent: 只弹出
    func tg_open(viewController: UIViewController,animated: Bool = true, onlyPresent: Bool = false) -> Bool{
        let result: Bool = false
        if(self.isKind(of: UIViewController.self)){
            if (!onlyPresent && nil != (self as! UIViewController).navigationController) {
                (self as! UIViewController).navigationController?.pushViewController(viewController, animated: animated)
            }
            else {
                (self as! UIViewController).present(viewController, animated: true)
            }
        }
        return result
    }
    /// 打开
    /// - Parameters:
    ///   - className: 类名
    ///   - parmasFormat: 参数
    /// - Returns: 执行结果
    func tg_open(className: String?, parmasFormat: NSDictionary = [:]) -> Bool{
        var result: Bool = false
        var controller: UIViewController
        do {
            if (nil == className || className?.count ?? 0 < 1){
                throw NSException.init(name: NSExceptionName("host null"), reason: "host is null") as! Error
            }
            let anyClass: AnyClass? = NSClassFromString(className!)
            if (nil == anyClass) {
                throw NSError.init(domain: "class is null", code: 404)
            }
            let controllerClass: UIViewController.Type = anyClass as! UIViewController.Type
            controller = controllerClass.initWithParams(parmasFormat: parmasFormat)
            //            if (controllerClass.isKind(of: UIViewController.self)){
            //                controller = controllerClass.initWithParams(parmasFormat: parmasFormat)
            //            }
            //            else {
            //                throw NSError.init(domain: "", code: 404)
            //            }
            
            //
            //              controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
            //              let animated: Bool = true
            //              let hidesBottomBarWhenPushed: Bool = controller.hidesBottomBarWhenPushed
            //              let modalPresentationStyle: UIModalPresentationStyle = controller.modalPresentationStyle
            let parmasFormat: NSMutableDictionary = NSMutableDictionary.init()
            
            //              controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
            //              controller.modalPresentationStyle = modalPresentationStyle
            //            controller = controller.initWithParams(parmasFormat: parmasFormat)
            
            
            //              result = self.tg_open(viewController: controller,animated: animated)
        }
        catch{
            result = false
        }
        return result
    }
    
    func tg_open(scheme: String?, host: String?, port: Int?, path: String?, parmasFormat: NSDictionary?) -> Bool{
        var result: Bool = false
        switch(scheme?.lowercased()){
        case "push":
            result = self.tg_push(scheme: scheme, host: host, port: port, path: path, parmasFormat: parmasFormat)
            break
        case "present":
            //            result = self.tg_open(className: host, parmasFormat: parmasFormat)
            break
        case .none:
            break
        case .some(_):
            break
        }
        return result;
    }
    /// 打开
    /// - Parameters:
    ///   - scheme: 模式
    ///   - host: 域名
    ///   - port: 端口
    ///   - path: 路径
    ///   - queryItems: 餐素
    /// - Returns: 执行结果
    func tg_open(scheme: String? = "push", host: String?, port: Int? = 80, path: String? = "/", queryItems: [URLQueryItem]?) -> Bool {
        let parmasFormat: NSMutableDictionary = NSMutableDictionary.init()
        
        queryItems?.forEach({ queryItem in
            parmasFormat.setObject(queryItem.value ?? "", forKey: queryItem.name as NSCopying)
        })
        return self.tg_open(scheme: scheme, host: host, port: port, path: path, parmasFormat: parmasFormat)
    }
    /// 打开地址
    /// - Parameter components: URL Components
    /// - Returns: 执行结果
    func tg_open(_ components: URLComponents?) -> Bool{
        var resutl: Bool = false
        do {
            if (nil == components) {
                throw NSException.init(name: NSExceptionName(rawValue: "") , reason: "") as! Error
            }
            let scheme: String = components?.scheme ?? ""
            let host: String = components?.host ?? ""
            let port: Int? = components?.port
            let path: String = components?.path ?? ""
            resutl = self.tg_open(scheme: scheme, host: host, port: port,path: path, queryItems: components?.queryItems)
        }
        catch {
            resutl = false
        }
        return resutl
    }
    /// 打开地址
    /// - Parameter url: 地址 NSURL
    /// - Returns: 执行地址
    func tg_open(_ url: NSURL) -> Bool{
        return false
    }
    /// 打开地址
    /// - Parameter url: 地址URL
    /// - Returns: 执行结果
    func tg_open(_ url: URL) -> Bool{
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        return self.tg_open(components)
    }
    /// 打开地址
    /// - Parameter urlString: 地址字符串
    /// - Returns: 执行结果
    func tg_open(urlString: String?) -> Bool{
        if (urlString?.count ?? 0 < 1) {
            return false
        }
        let components = URLComponents(string: urlString!)
        return self.tg_open(components)
    }
}
