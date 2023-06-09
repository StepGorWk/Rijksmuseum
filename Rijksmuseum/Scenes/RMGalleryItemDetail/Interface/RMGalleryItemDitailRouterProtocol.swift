//
//  RMGalleryItemDetailRouterProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import UIKit

protocol RMGalleryItemDetailRouterProtocol: AnyObject {
    static func createModule(with artModel: RMArtModel) -> UIViewController
}
