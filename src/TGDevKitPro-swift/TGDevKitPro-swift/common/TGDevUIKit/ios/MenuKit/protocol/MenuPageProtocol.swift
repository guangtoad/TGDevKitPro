//
//  MenuPageProtocol.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/12.
//


// MARK: -

public struct TGMenuKitKeys {
    public static var tgkey_menuData = "tgkey_menuData"
    public static let TGKEY_MENU = "menu"
    public static let TGKEY_MENUS = "menus"
    public static let TGKEY_GROUPS = "groups"
    public static let TGKEY_URL = "url"
    public static let TGKEY_TITLE = "title"
    public static let TGKEY_DESCRIPTION = "description"
}

// MARK: -

extension UIViewController{
    // MARK: - 数据操作
    /// 菜单数据
    var menuData : NSMutableDictionary?{
        get {
            var _menuData =  objc_getAssociatedObject(self, &TGMenuKitKeys.tgkey_menuData) as? NSMutableDictionary
            if(nil == _menuData) {
                _menuData = NSMutableDictionary.init()
                self.menuData = _menuData
            }
            return _menuData
        }
        set {
            objc_setAssociatedObject(self, &TGMenuKitKeys.tgkey_menuData, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

/// 菜单页面协议
protocol MenuPageViewContollerProtocol:UIViewControllerTGRouterProtocol, UIViewController, NSObjectProtocol {
    // MARK: - 数据控制
    /// 数据路径
    /// - Returns: 路径
    func menuDataFilePath() -> String
    // MARK: - 数据控制
    /// 加载数据
    /// - Parameter dataFilePath: 数据路径
    func loadMenuData(dataFilePath:String?)
    func reloadMenuData()
    /// 获取菜单组列表
    /// - Returns: 菜单组列表
    func menuItems() -> NSArray
    /// 获取菜单组
    /// - Parameter section: 第几节
    /// - Returns:
    func menuItem(section:Int) -> NSDictionary
    func menuItems(section:Int) -> NSArray
    func menuItem(section: Int, row: Int) -> NSDictionary
    func menuItem(indexPath:IndexPath) -> NSDictionary
    func defMenuInfo() -> NSDictionary
    // MARK: - UI 控制
    /// 注册菜单控件
    /// - Returns: void
    func registerMenuItemView() -> Void
}

extension MenuPageViewContollerProtocol{
    // MARK: - 默认数据
    /// 默认数据
    /// - Returns: <#description#>
    func defMenuInfo() -> NSDictionary{
        return [:]
    }
    // MARK: - 数据控制
    /// 菜单数据地址
    /// - Returns: 菜单数据地址
    func menuDataFilePath() -> String{
        return Bundle.main.path(forResource: NSStringFromClass(self.classForCoder), ofType: "plist") ?? ""
    }
    /// 加载数据
    /// - Parameter dataFilePath: 数据路径
    func loadMenuData(dataFilePath:String?){
        if (nil == dataFilePath || dataFilePath?.count ?? 0 < 1) {
            
        }
        else {
            let dict = NSDictionary.init(contentsOfFile: dataFilePath!)
            self.menuData?.setDictionary((dict ?? [:]) as! [AnyHashable : Any]? ?? [:])
        }
    }
    /// 重新加载菜单数据
    func reloadMenuData() {
        self.menuData?.removeAllObjects()
        self.loadMenuData(dataFilePath: self.menuDataFilePath())
    }
    /// 获取所有菜单主
    /// - Returns: 菜单组列表
    func menuItems() -> NSArray {
        let menuItems = self.menuData?.object(forKey: TGMenuKitKeys.TGKEY_MENU)
        let result: NSArray = menuItems as? NSArray ?? []
        return result
    }
    /// 获取菜单组
    /// - Parameter section: 第几组
    /// - Returns: 菜单组数据
    func menuItem(section: Int) -> NSDictionary {
        let menuItems: NSArray = self.menuItems()
        let menuItem: NSDictionary = (menuItems[section] as? NSDictionary) ?? self.defMenuInfo()
        return menuItem
    }
    /// 获取某组菜单数据列表
    /// - Parameter section: 第几
    /// - Returns: 数据列表
    func menuItems(section: Int) -> NSArray {
        let menu: NSDictionary = menuItem(section: section)
        let menuItems: NSArray =  (menu.object(forKey: TGMenuKitKeys.TGKEY_MENU) as? NSArray) ?? []
        return menuItems
    }
    /// 获取数据
    /// - Parameters:
    ///   - section: 节
    ///   - row: 行
    /// - Returns: item
    func menuItem(section: Int, row: Int) -> NSDictionary{
        let menuItems: NSArray = self.menuItems(section: section)
        if (row < menuItems.count){
            let menuInfo = (menuItems[row] as? NSDictionary) ?? self.defMenuInfo()
            return menuInfo
        }
        else {
            return self.defMenuInfo()
        }
    }
    /// 获取详细数据
    /// - Parameter indexPath: indexPath
    /// - Returns: 详细数据
    func menuItem(indexPath: IndexPath) -> NSDictionary {
        let section = indexPath.section
        let row = indexPath.row
        return self.menuItem(section: section, row: row)
    }
    
}

// MARK: -
/// 菜单页面协议
protocol MenuPageCollectionViewContollerProtocol: UITableViewDataSource,UITableViewDelegate,NSObject {
    
}
