//
//  RMGalleryItemDetailFetchService.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

class RMGalleryItemDetailFetchService: BaseNetworkManager, RMGalleryItemDetailFetchServiceProtocol {
    
    func getGalleryItemDetail<T>(objectNumber: String, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? where T : Decodable {
        var components = URLComponents()
        components.scheme = Schem.https.rawValue
        components.host = Host.rijksmuseum.rawValue
        components.path = String(format: Path.details.rawValue, objectNumber)
        components.queryItems = RMBaseRequest().queryItems()
        return session.execute(components: components, completion: completion)
    }
}
