//
//  RealmObject.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/13.
//

import UIKit
import RealmSwift

/// Realm 对象
class RealmObject: Object {
    
    /// 主见默认加一个ID
    @Persisted(primaryKey: true) var _id: String
    
}
