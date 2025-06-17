//
//  DevKitError.swift
//  DevKitPro
//
//  Created by toad on 2025/5/19.
//

import Foundation

public enum DevKitError: Swift.Error {
    case illegalValue(Any)
    case illegalFileURL(URL)
    case cannotGetFileSize(URL)
}
