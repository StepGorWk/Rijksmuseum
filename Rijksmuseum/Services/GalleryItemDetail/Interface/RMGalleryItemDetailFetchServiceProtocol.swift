//
//  RMGalleryItemDetailFetchServiceProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

protocol RMGalleryItemDetailFetchServiceProtocol {
    
    @discardableResult func getGalleryItemDetail<T: Decodable>(objectNumber: String, completion: @escaping(Result<T, Error>) -> Void) -> URLSessionDataTask?
}
