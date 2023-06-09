//
//  RMGalleryCollectionRouterProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import UIKit

protocol RMGalleryCollectionRouterProtocol: AnyObject {
    var navigationController: RMBaseNavigationController? { get }
    static func createModule() -> UIViewController
    func navigateToDetail(with artModel: RMArtModel)
}
