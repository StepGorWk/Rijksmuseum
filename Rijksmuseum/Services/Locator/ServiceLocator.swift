//
//  ServiceLocator.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//
import Swinject
import SwinjectAutoregistration

class ServiceLocator: ServiceLocatorProtocol {
    private let container = Container()
    
    func registerServices<Service>(_ service: Service.Type, initializer: @escaping (()) -> Service) {
        container.autoregister(service, initializer: initializer)
    }
    
    func getService<T>(_ type: T.Type) -> T? {
        return container.resolve(type)
    }
}
