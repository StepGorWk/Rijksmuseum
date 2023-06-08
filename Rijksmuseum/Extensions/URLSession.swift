//
//  URLSession.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

extension URLSession {
    
   @discardableResult func execute<T: Decodable>(components: URLComponents, method: HttpMethode = .get, completion: @escaping(Result<T, Error>) -> Void) -> URLSessionDataTask? {
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let dataTask = dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
             
            guard response != nil, let data = data else {
                completion(.failure(HttpError.badURL))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            }
            catch let error {
                print(error)
                completion(.failure(HttpError.incorrectDTO))
            }
        }
        
        dataTask.resume()
        return dataTask
    }
}
