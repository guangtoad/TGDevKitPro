//
//  BaseUIController.swift
//  DevKitPro
//
//  Created by toad on 2025/4/21.
//

import UIKit

@IBDesignable
class BaseUIViewController: UIViewController {
    
}

extension UIViewController{
    
    func showAlert(title: String?, message: String?,preferredStyle: UIAlertController.Style,animated: Bool ,actions: UIAlertAction...) ->Void{
        let alert =  UIAlertController(title: title, message: message, preferredStyle: preferredStyle);
       
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: animated);
    }
    
    func showAlert(title: String?, message: String?,actions: UIAlertAction...) ->Void{
        self.showAlert(title: title, message: message, preferredStyle: UIAlertController.Style.alert,animated:true);
    }
    
}
