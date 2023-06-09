//
//  RMGalleryCollectionPresenterProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation
import UIKit

typealias ArtModelSnapshot = NSDiffableDataSourceSnapshot<String, RMArtModel>
typealias RMGalleryCollectionPresenterInputProtocol = RMGalleryCollectionInteractorOutputProtocol

protocol RMGalleryCollectionPresenterProtocol: RMPaginationPresenterProtocol {
    func viewDidLoad()
    func snapshot() -> ArtModelSnapshot
    func item(at indexPath: IndexPath) -> RMArtModel?
}
