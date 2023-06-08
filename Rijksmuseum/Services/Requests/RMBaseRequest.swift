//
//  RMBaseRequest.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

class RMBaseRequest {
    let key = "0fiuZFh4"
}

extension RMBaseRequest {
    
    func queryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        let mirror = Mirror(reflecting: self)
        items.append(URLQueryItem(name: "key", value: "\(self.key)"))
        
        for child in mirror.children {
            if let label = child.label {
                items.append(URLQueryItem(name: label, value: "\(child.value)"))
            }
        }
        return items
    }
}
