//
//  MenuPageTableViewController.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/6.
//

import UIKit

class MenuPageTableViewController: TableViewController, MenuPageTableViewContollerProtocol{
    
    func menuDataFilePath() -> String {
        guard var spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("获取命名空间失败")
            return NSObject() as! String
        }
        let claseName = NSStringFromClass(type(of: self))
        let resourcePath = Bundle.main.resourcePath
        let path: String? = resourcePath?.appending(String(format:"/DataBase/Menu/%@.plist", arguments:[claseName]))
        return path ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (nil != (self.tableView)){
            if (nil == (self.tableView?.delegate)) {
                self.tableView?.delegate = (self);
            }
            if (nil == (self.tableView?.dataSource)) {
                self.tableView?.dataSource = self;
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadMenuData()
        self.tableView.reloadData()
    }
    
    func loadMenuWithPath(path: String) -> Void {
        //        var resourcePath =  Bundle.main.resourcePath
        //        var filePath = resourcePath.appendingPathComponent(String, conformingTo: <#UTType#>)
        
    }
    
    func registerMenuItemView() -> Void {
        var nib : UINib
        nib = UINib.init(nibName: "MenuPageTableViewCell", bundle: nil)
        self.tableView?.register(nib, forCellReuseIdentifier: "Menu")
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let result: Int = self.menuItems().count
        return result
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result: Int = self.menuItems(section: section).count
        return result
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let menuItem : NSDictionary = self.menuItem(section: section)
        let title : String = menuItem.object(forKey: "title") as? String ?? ""
        return title;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "")
        let menItem = self.menuItem(indexPath: indexPath)
        cell.tg_roulerLink = (menItem.object(forKey: TGMenuKitKeys.TGKEY_URL) as? String) ?? ""
        cell.textLabel?.text = (menItem.object(forKey: TGMenuKitKeys.TGKEY_TITLE) as? String) ?? ""
        return cell;
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath);
        cell?.setSelected(false, animated: true)
        if (nil != cell?.tg_roulerLink){
           _ = self.tg_open(urlString: cell?.tg_roulerLink)
//            self.tg_open(<#T##url: URL##URL#>)
            //            _ = self.tg_open(URL.init(string: (cell?.tg_roulerURL!)!)!)
        }
    }
    
}
