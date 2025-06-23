//
//  MenuPageViewController.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2022/12/6.
//

import UIKit

class MenuPageViewController: DataSourceViewController, MenuPageViewContollerProtocol {
//    var any: AnyClass
  
    /// 重新加载数据
    /// - Returns: void
    func reloadMenuData() -> Void {
    }
    /// 重新加载菜单视图
    /// - Returns: void
    func reloadMenuView() -> Void {
        
    }
    /// 重新加载菜单数据和视图
    /// - Returns: void
    func reloadMenuDataAndView() -> Void {
        self.reloadMenuData();
        self.reloadMenuView();
    }
    /// 注册菜单控件
    /// - Returns: void
    func registerMenuItemView() -> Void {
    }
    /// 获取菜单组列表
    /// - Returns: 菜单组列表
    func menuItems() -> NSArray{
        return []
    }
    /// 获取菜单组
    /// - Parameter section: 第几节
    /// - Returns:
    func menuItem(section:Int) -> NSDictionary {
        return [:]
    }
    func menuItems(section:Int) -> NSArray{
        return []
    }
    func menuItem(indexPath:NSIndexPath) -> NSDictionary {
        return [:]
    }
    func dataNumber(section:Int) -> Int{
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated);
        if (!self.isDataLoaded){
            self.reloadMenuDataAndView();
            self.isDataLoaded = true;
        }
    }
    
}
