//
//  View.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/12.
//

#if os(iOS)

class TGBaseView: UIView {
    
}

#elseif os(macOS)

class TGBaseView: NSView {
    
}

#elseif os(tvOS)

#elseif os(visionOS)

#endif

extension TGBaseView{
    func request() -> Bool {
        let result: Bool = false
        if(nil != self.requestAppender){
            
        }
        return result
    }
}

#if os(iOS)

#elseif os(macOS)
        
#elseif os(tvOS)
        
#elseif os(visionOS)
        
#endif
