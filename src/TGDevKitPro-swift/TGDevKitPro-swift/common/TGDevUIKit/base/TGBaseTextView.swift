//
//  TextView.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/12.
//

#if os(iOS)

class TextView: UITextView {
}


#elseif os(macOS)

class TextView: NSTextView {
}

#elseif os(tvOS)

#elseif os(visionOS)

#endif
