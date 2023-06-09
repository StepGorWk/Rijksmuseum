//
//  MockGalleryItemDetailFetchService.swift
//  RijksmuseumUITests
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation
@testable import Rijksmuseum

class MockGalleryItemDetailFetchService: RMGalleryItemDetailFetchServiceProtocol {
    func getGalleryItemDetail<T>(objectNumber: String, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? where T : Decodable {
        MockService().load("ArtObjectDetail", completion: completion)
        return nil
    }
}
