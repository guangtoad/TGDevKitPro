//
//  BaseUIView.swift
//  DevKitPro
//
//  Created by toad on 2025/4/28.
//

#if os(iOS)

@IBDesignable

extension UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}

#elseif os(macOS)

@IBDesignable
extension NSView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}

#elseif os(tvOS)
#elseif os(visionOS)
#endif
