//
//  RMGalleryCollectionFetchServiceProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

protocol RMGalleryCollectionFetchServiceProtocol {
    
    @discardableResult func getGalleryCollection<T: Decodable>(request: RMPaginationRequest, completion: @escaping(Result<T, Error>) -> Void) -> URLSessionDataTask?
}
