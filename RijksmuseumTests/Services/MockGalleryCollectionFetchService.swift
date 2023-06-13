//
//  MockGalleryCollectionFetchService.swift
//  RijksmuseumUITests
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation
@testable import Rijksmuseum

class MockGalleryCollectionFetchService: RMGalleryCollectionFetchServiceProtocol {
    func getGalleryCollection<T>(request: Rijksmuseum.RMPaginationRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? where T : Decodable {
        if request.p == 0 {
            MockService().load("Collection", completion: completion)
        } else {
            MockService().load("Collection1", completion: completion)
        }
        return nil
    }
}
