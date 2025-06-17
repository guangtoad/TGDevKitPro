//
//  TableViewCell.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/12.
//

import UIKit
private var key: Void?
extension UITableViewCell{
    var dataInfo : AnyObject {
        get {
            return objc_getAssociatedObject(self, &key)! as AnyObject
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    class TableViewCell: UITableViewCell {
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
    }
}
