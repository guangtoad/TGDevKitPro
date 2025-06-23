//
//  Button.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/12.
//


#if os(iOS)

class TGBaseButton: UIButton {
    
}

#elseif os(macOS)

class TGBaseButton: NSButton {
    
}

#elseif os(tvOS)
#elseif os(visionOS)
#endif

extension TGBaseButton {
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
