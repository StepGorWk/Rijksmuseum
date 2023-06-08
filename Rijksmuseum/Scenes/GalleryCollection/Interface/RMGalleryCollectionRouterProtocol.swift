//
//  RMGalleryCollectionRouterProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import UIKit

protocol RMGalleryCollectionRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToDetail()
}
