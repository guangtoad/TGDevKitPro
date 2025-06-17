//
//  TGRouterViewControllerProtocol.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/26.
//

import UIKit

// MARK: -

protocol UIViewControllerTGRouterProtocol:TGRouterProtocol, UIViewController{
    
}

extension UIViewControllerTGRouterProtocol{
    
    func tg_push(scheme: String?, host: String?, port: Int?, path: String?, parmasFormat: NSDictionary?) -> Bool{
        var result: Bool = false
        let anyClass: AnyClass? = self.tg_create(scheme: scheme, host: host, port: port, path: path, parmasFormat: parmasFormat)
        
        let controolerCloass: UIViewController.Type? = anyClass as? UIViewController.Type
        let controller = DevWebMenuController.init()
        //        let controller = controolerCloass?.initWithParams(parmasFormat: parmasFormat)
        if (nil != controller) {
            result = self.tg_open(viewController: controller)
        }
        return result
    }
}
