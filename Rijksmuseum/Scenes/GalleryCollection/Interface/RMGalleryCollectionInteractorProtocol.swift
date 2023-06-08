//
//  RMGalleryCollectionInteractorProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

typealias ArtModels = [RMArtModel]

protocol RMGalleryCollectionInteractorProtocol: RMPaginationInteractorProtocol {
    var artObjectSections: [RMArtObjectSection] { get }
    var isFetching: Bool { get }
    
    init(serviceLocator: ServiceLocatorProtocol)
    func fetchData()
    func fetchNextPage()
}

protocol RMGalleryCollectionInteractorOutputProtocol: AnyObject {
    func didFetchData()
    func didFail(with error: Error)
}
