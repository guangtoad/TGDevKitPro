//
//  TableView.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/19.
//


#if os(iOS)

class TGBaseTableView: UITableView {
    
    
}

#elseif os(macOS)

class TGBaseTableView: NSTableView {
    
    
}
#elseif os(tvOS)

#elseif os(visionOS)

#endif

extension TGBaseTableView{
    
}
