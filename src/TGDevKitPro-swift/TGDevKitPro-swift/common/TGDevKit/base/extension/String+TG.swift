//
//  String+TG.swift
//  TGFoundationSwift
//
//  Created by toad on 2022/07/27.
//

import Foundation

extension String{
    func boolValue(defValue: Bool = false) -> Bool {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return defValue
        }
    }
    static func boolValue(valueStr: String?, defValue: Bool = false) -> Bool{
        if (nil != valueStr) {
            return valueStr!.boolValue(defValue: defValue)
        }
        else {
            return defValue
        }
    }
}
