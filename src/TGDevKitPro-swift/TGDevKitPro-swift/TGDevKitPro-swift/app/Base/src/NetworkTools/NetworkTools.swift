//
//  NetworkTools.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/24.
//

import UIKit

class NetworkTools: MenuPageTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isKind(of: UIViewController.self){
            NSLog("1")
        }
        else {
            NSLog("2")
        }
        NSLog(NSStringFromClass(self.classForCoder))
        let a = NSClassFromString(NSStringFromClass(self.classForCoder)) as? MenuPageTableViewController.Type
        if ((a?.isKind(of: UIViewController.self)) != nil) {
            NSLog("11")
        }
             else {
            NSLog("22")
        }
//        self.classForCoder.isKind(<#T##self: NSObjectProtocol##NSObjectProtocol#>)
    }
    
}
