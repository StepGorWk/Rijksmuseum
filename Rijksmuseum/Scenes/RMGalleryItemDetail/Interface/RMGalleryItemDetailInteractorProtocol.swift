//
//  RMGalleryItemDetailInteractorProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

protocol RMGalleryItemDetailInteractorProtocol: AnyObject {
    var detail: RMGalleryItemDetailModel? { get }
    init(serviceLocator: ServiceLocatorProtocol, artObject: RMArtModel)
    func fetchDetail()
}

protocol RMGalleryItemDetailInteractorOutputProtocol: AnyObject {
    func didFetchData()
    func didFail(with error: Error)
}
