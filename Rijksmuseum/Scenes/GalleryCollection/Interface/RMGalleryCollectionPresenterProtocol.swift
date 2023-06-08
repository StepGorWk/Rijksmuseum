//
//  RMGalleryCollectionPresenterProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

protocol RMGalleryCollectionPresenterProtocol: RMPaginationPresenterProtocol {
    func viewDidLoad()
    func sectionCount() -> Int
    func numberOfItems(section: Int) -> Int
    func item(at indexPath: IndexPath) -> RMArtModel?
}

protocol RMGalleryCollectionPresenterOutputProtocol {
    func didFetchData(artModels: [RMArtModel])
    func didFail(with error: Error)
}
