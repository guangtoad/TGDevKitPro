//
//  TGBaseTableViewCell.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/3/23.
//


class TGBaseTableViewCell: UITableViewCell {
    
    func reload(info: NSDictionary) -> Void {
        
    }
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
