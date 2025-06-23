//
//  GlobalImports.swift
//  TGDevUIKit
//
//  Created by toad on 2025/6/19.
//

@_exported import Foundation

@_exported import SwiftUI // 如果需要
#if os(iOS)
@_exported import UIKit    // 如果是 iOS 项目
#elseif os(macOS)
@_exported import Cocoa    // 如果是 macOS 项目
#elseif os(tvOS)
#elseif os(visionOS)
#endif
