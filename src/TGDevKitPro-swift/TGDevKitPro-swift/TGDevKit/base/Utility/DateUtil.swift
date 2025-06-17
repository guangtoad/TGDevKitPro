//
//  DateUtil.swift
//  DevKitPro
//
//  Created by toad on 2025/4/21.
//

import Foundation

extension NSDate {
    /// 将NSDate对象转换为指定格式的字符串
    /// - Parameter format: 日期格式字符串
    /// - Returns: 格式化后的日期字符串
    func formattedString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
    }
}

extension String {
    /// 将字符串转换为UTC时区的日期字符串
    /// - Parameter format: 日期格式字符串
    /// - Returns: UTC时区的日期字符串，如果转换失败则返回nil
    func utcFormattedString(with format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: date)
    }
    
    /// 将字符串转换为本地时区的日期字符串
    /// - Parameter format: 日期格式字符串
    /// - Returns: 本地时区的日期字符串，如果转换失败则返回nil
    func localFormattedString(with format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}