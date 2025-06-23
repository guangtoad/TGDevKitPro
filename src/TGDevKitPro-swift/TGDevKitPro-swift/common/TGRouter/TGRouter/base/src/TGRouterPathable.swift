//
//  RouterPathable.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/26.
//

import UIKit


protocol TGRouterPathable: NSObjectProtocol {
    func initWithParams(parmas: NSDictionary?) -> AnyObject
}

extension TGRouterPathable {
}

protocol ViewControllerTGRouterPathable:UIViewController, NSObjectProtocol{
    
}

extension ViewControllerTGRouterPathable{
    func initWithParams(parmas: NSDictionary?) -> AnyObject{
        return self
    }
}
