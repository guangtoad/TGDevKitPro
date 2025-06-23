//
//  CollectionView.swift
//  TG Develop Tools iOS
//
//  Created by toad on 2023/4/19.
//


#if os(iOS)

class TGBaseCollectionView: UICollectionView {
    
}

#elseif os(macOS)

class TGBaseCollectionView: NSCollectionView {
    
}

#elseif os(tvOS)
#elseif os(visionOS)
#endif
