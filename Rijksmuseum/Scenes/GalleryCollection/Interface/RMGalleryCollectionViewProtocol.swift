//
//  RMGalleryCollectionViewProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

protocol RMGalleryCollectionViewProtocol: AnyObject {
    func showGalleryCollection()
    func showError(_ message: String)
}
