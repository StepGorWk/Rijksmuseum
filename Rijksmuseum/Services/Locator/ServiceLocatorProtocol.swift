//
//  ServiceLocatorProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

protocol ServiceLocatorProtocol: AnyObject {
    func registerServices<Service>(_ service: Service.Type, initializer: @escaping (()) -> Service)
    func getService<T>(_ type: T.Type) -> T?
}
