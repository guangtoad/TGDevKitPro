//
//  UIResponder+TGRoule.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/23.
//

import UIKit

extension UIResponder {
    
    @IBInspectable var IB_roulerURL: String? {
        get {
            return self.tg_roulerLink
        }
        set {
            self.tg_roulerLink = newValue
        }
    }
    
    @IBAction func tg_clickOpen(_ sender: Any){
        let object = sender as! NSObject
        if (object.isKind(of: NSObject.self)) {
//            _ = self.tg_open(object.tg_roulerURL ?? "")
        }
    }
    
}



