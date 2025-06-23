//
//  TGFileUtil.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/3/22.
//

import Foundation


class TGFileUtil: NSObject {
    
//    func isNullValue(obj: NSObject, aClass: AnyClass) -> Bool {
//        if(0 == obj.accessibilityElementCount()){
//            return true
//        }
//        return false;
//    }
    
    func filePath(filePath : String, basePath basePathOrNil: String?) -> String {
//        self.isKind(of: NSObject.self)
        return ""
    }
    
    func documentPath(aPath: String) -> String {
        let document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return self.filePath(filePath: aPath, basePath: document)
    }
    
    func resourcePath(filePath: String,  bundle nibBundleOrNil: Bundle?) -> String {
        return ""
    }
    func resourcePath(filePath: String) -> String{
        return self.resourcePath(filePath: filePath, bundle: nil)
    }
}
