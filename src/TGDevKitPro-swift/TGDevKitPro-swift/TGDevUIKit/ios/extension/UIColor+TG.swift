//
//  UIColor+TG.swift
//  TGUIKit
//
//  Created by toad on 2022/07/27.
//

import UIKit

public extension UIColor {
    
    /// <#Description#>
    /// - Parameters:
    ///   - rgbHex: hex值
    ///   - alpha: alpha值，默认1.0
    /// - Returns: <#description#>
    class func colorWithHex(rgbHex:NSString, alpha:CGFloat = 1.0) -> UIColor {
        
        var cString : NSString =
        rgbHex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if (cString.length < 6){
            return UIColor.white;
        }
        
        if (cString.hasPrefix("0X")){
            
            cString = cString.substring(from: 2) as NSString;
        }
        else if (cString.hasPrefix("#")){
            cString = cString.substring(from:1) as NSString;
        }
        if (6 != cString.length) {
            return UIColor.white;
        }
        var range : NSRange = NSRange.init(location: 0 , length: 2);
        
        let rString : NSString = cString.substring(with: range) as NSString;
        range.location += range.length;
        let gString : NSString = cString.substring(with: range) as NSString;
        range.location += range.length;
        let bString : NSString = cString.substring(with: range) as NSString;
        range.location += range.length;
        var r,g,b : CLong
        r = CLong(strtoul(rString.utf8String, nil, 16));
        g = CLong(strtoul(gString.utf8String, nil, 16));
        b = CLong(strtoul(bString.utf8String, nil, 16));
        
        return self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: alpha);
    }
}


