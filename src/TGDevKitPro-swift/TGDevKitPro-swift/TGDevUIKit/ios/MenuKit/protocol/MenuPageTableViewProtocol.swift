//
//  MenuPageTableViewContollerProtocol.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/24.
//

import UIKit

/// 菜单页面协议
protocol MenuPageTableViewContollerProtocol: MenuPageViewContollerProtocol,  UITableViewDataSource, UITableViewDelegate {
    
    override func numberOfSections(in tableView: UITableView) -> Int
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//    /// Description
//    /// - Parameters:
//    ///   - tableView: tableView description
//    ///   - section: section description
//    /// - Returns: description
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    /// Description
//    /// - Parameters:
//    ///   - tableView: tableView 图标
//    ///   - indexPath: indexPath 引索
//    /// - Returns: description
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
}
/// 菜单页面协议
extension MenuPageTableViewContollerProtocol {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.menuItems().count
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let group : NSDictionary = self.menuItem(section: section)
//        let title : String = group.object(forKey: "") as! String;
//        return title;
//    }
    /// Description
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - section: section description
    /// - Returns: description
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems(section: section).count
    }
    /// Description
    /// - Parameters:
    ///   - tableView: tableView 图标
    ///   - indexPath: indexPath 引索
    /// - Returns: description
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "")
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath);
        cell?.setSelected(false, animated: true)
        if (nil != cell?.tg_roulerLink){
            _ = self.tg_open(URL.init(string: (cell?.tg_roulerLink!)!)!)
        }
    }
 
}
