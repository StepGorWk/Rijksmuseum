//
//  RMGalleryItemDetailViewProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

protocol RMGalleryItemDetailViewProtocol: AnyObject {
    func showDetails()
    func showError(_ message: String)
}
