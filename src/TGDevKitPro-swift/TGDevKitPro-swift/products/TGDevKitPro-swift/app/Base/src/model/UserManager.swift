//
//  UserManager.swift
//  DevKitPro
//
//  Created by toad on 2025/4/28.
//

import Foundation

class UserDataManager {
    // 单例模式，确保全局只有一个实例
    static let shared = UserDataManager()
    
    // 私有初始化方法，防止外部创建实例
    private init() {}
}
