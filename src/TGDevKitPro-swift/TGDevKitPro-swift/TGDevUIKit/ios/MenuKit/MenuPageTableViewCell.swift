//
//  MenuPageTableViewCell.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/6.
//

import UIKit


class MenuPageTableViewCell: UITableViewCell {
    
    @IBOutlet var txtTitle: UILabel!
    @IBOutlet var txtDescription: UILabel!
    @IBOutlet var imgIcon: UIImageView!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func itemIdentifier() -> String{
        return NSStringFromClass(self)
    }
    
    static func register(tableView: UITableView?) {
        tableView?.register(self.classForCoder(), forCellReuseIdentifier: self.itemIdentifier())
    }
    
}
