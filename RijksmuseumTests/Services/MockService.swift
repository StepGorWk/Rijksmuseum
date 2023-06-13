//
//  MockService.swift
//  RijksmuseumUITests
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

enum MockServiceError: Error {
    case failToFind
    case failToLoad
    case failToPars
}

class MockService {
    func load<T: Decodable>(_ filename: String, completion: @escaping (Result<T, Error>) -> Void) {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: ".json")
        else {
            completion(.failure(MockServiceError.failToFind))
            return
        }
        
        do {
            data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            let responseObject = try decoder.decode(T.self, from: data)
            completion(.success(responseObject))
        } catch {
            completion(.failure(MockServiceError.failToPars))
        }
    }
}

