//
//  RMGalleryCollectionFetchService.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

class RMGalleryCollectionFetchService: BaseNetworkManager, RMGalleryCollectionFetchServiceProtocol {
    
    func getGalleryCollection<T>(request: RMPaginationRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? where T : Decodable {
        var components = URLComponents()
        components.scheme = Schem.https.rawValue
        components.host = Host.rijksmuseum.rawValue
        components.path = Path.collection.rawValue
        components.queryItems = request.queryItems()
        return session.execute(components: components, completion: completion)
    }
}
