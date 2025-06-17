//
//  TGDataLoadAppender.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/21.
//

import Foundation

protocol TGRequestAppender: NSObjectProtocol{
    
    func request(sender: AnyObject) -> Bool
    
}
