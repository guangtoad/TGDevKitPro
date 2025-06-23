//
//  BaseUISplitViewController.swift
//  DevKitPro
//
//  Created by toad on 2025/6/5.
//

#if os(iOS)

class TGBaseSplitViewController: UISplitViewController {
}


#elseif os(macOS)

class TGBaseSplitViewController: NSSplitViewController {
}

#elseif os(tvOS)

#elseif os(visionOS)

#endif

extension TGBaseSplitViewController {
    
}
