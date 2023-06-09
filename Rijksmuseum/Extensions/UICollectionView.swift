//
//  UICollectionView.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(for type: T.Type) {
        let identifier = String(describing: T.self)
        register(type, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeue<T: UICollectionReusableView>(_ elementKind: String, indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func register<T: UICollectionReusableView>(for type: T.Type) {
        let identifier = String(describing: T.self)
        register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }
}
