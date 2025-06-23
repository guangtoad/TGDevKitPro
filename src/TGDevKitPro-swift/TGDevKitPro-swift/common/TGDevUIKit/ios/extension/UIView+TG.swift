//
//  UIView+TG.swift
//  TGUIKit
//
//  Created by toad on 2022/07/29.
//

import Foundation
import UIKit

public extension UIView {
    func setCornerRadius(radius:CGFloat) -> Void {
        self.layer.masksToBounds = radius > 0 ? true : false;
        self.layer.cornerRadius = radius;
    }
}
