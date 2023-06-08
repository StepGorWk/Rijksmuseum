//
//  Endpoint.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

enum Schem: String {
    case http
    case https
}

enum Host: String {
   case rijksmuseum = "www.rijksmuseum.nl"
}

enum Path: String {
    case collection = "/api/en/collection"
}

enum HttpMethode: String {
    case put = "PUT"
    case get = "GET"
    case post = "POST"
}

enum HttpError: Error {
    case badURL
    case incorrectDTO
}
