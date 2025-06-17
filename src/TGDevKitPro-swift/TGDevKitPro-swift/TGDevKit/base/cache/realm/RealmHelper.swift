//
//  RealmHelper.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/13.
//

import UIKit
import RealmSwift
import StoreKit

/// Realm 助手
class RealmHelper: NSObject {
   
    /// 单例实例
    fileprivate static let _shareInstance = RealmHelper()
    
    let queue = DispatchQueue(label: "org.alamofire.authentication.inspector")
    var realm : Realm? = nil
    /// 获取单例
    /// - Returns: 单例
    static func shareInstance() -> RealmHelper{
        return _shareInstance
    }
    ///  配置数据库
    public class func configRealm() {
        /// 这个方法主要用于数据模型属性增加或删除时的数据迁移，每次模型属性变化时，将 dbVersion 加 1 即可，Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构，移除属性的数据将会被删除。
        let dbVersion : UInt64 = 1
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        
        Realm.Configuration.defaultConfiguration = config
        
    }
    /// realm 文件名称
    /// - Returns: realm 文件名称
    public class func realmFileName() -> String{
        return "tg.db"
    }
    
    /// 获取realm配置
    /// - Parameter realmPath: realm数据库路径
    /// - Returns: realm 配置
    public class func getRealmConfig(realmUrl: URL) -> Realm.Configuration{
        /// 这个方法主要用于数据模型属性增加或删除时的数据迁移，每次模型属性变化时，将 dbVersion 加 1 即可，Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构，移除属性的数据将会被删除。
        let dbVersion : UInt64 = 1
        let config = Realm.Configuration(fileURL: realmUrl, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        return config
    }
    
    /// 获取realm配置
    /// - Parameter realmPath: realm数据库路径
    /// - Returns: realm 配置
    public class func getRealmConfig(realmPath: String) -> Realm.Configuration{
        let realmUrl: URL? = URL.init(string: realmPath)
        if (nil == realmUrl) {
            return Realm.Configuration.defaultConfiguration
        }
        else {
            return self.getRealmConfig(realmUrl: realmUrl!)
        }
//        return ""
    }
    /// 获取realm配置
    /// - Returns: realm 配置配置
    public class func getRealmConfig() -> Realm.Configuration{
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        
        return getRealmConfig(realmPath: "/defaultDB.realm")
    }
    /// 获取Realm路径
    /// - Returns: Realm路径
    public class func getRealmCachePath()-> String{
        return ""
    }
    /// 获取资源文件中的Realm路径
    /// - Returns: realm路径
    public class func getRealmPath()-> String{
        //        return Bundle.main.resourcePath +  "tg.realm"
        return self.realmFileName()
    }
    /// 初始化 realm
    /// - Returns: 初始化结果
    public class func initializationRealm() -> Bool{
        var result: Bool = false
        let fileManager: FileManager =  FileManager.default
        if (fileManager.fileExists(atPath: self.getRealmCachePath())){
            result = true
        }
        else {
            do {
                try fileManager.copyItem(atPath: self.getRealmPath(), toPath: self.getRealmCachePath())
            }
            catch{
                result = false
            }
        }
        return result
    }
    /// 初始化
    override init() {
        super.init()
        do {
            try self.realm = Realm.init(configuration: RealmHelper.getRealmConfig(), queue: self.queue)
            
        }
        catch {
        }
    }
    
}
