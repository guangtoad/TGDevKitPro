//
//  BaseObject.swift
//  DevKitPro
//
//  Created by toad on 2025/4/28.
//

import Foundation
import os.log

 

extension NSObject {
    
    @NSManaged public var closeDate: Date?
    func requestService() ->  HttpClient{
        return HttpClient();
    }
    func log(){
       let subsystem = "com.example.myapp"
       let category = "MyCategory"
       let log = OSLog(subsystem: subsystem, category: category)

        //        NSClassFromString("")
        
       os_log("Hello, World!", log: log, type: .info)
    }
    
}
