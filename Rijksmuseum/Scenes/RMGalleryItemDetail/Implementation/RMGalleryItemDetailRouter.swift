//
//  RMGalleryItemDetailRouter.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import UIKit

class RMGalleryItemDetailRouter: RMGalleryItemDetailRouterProtocol {
    
    static func createModule(with artModel: RMArtModel) -> UIViewController {
        let galleryItemDetailView = RMGalleryItemDetailViewController()
        let presenter = RMGalleryItemDetailPresenter()
        let router = RMGalleryItemDetailRouter()
        let serviceLocator = ServiceLocator()
        serviceLocator.registerServices(RMGalleryItemDetailFetchServiceProtocol.self, initializer: RMGalleryItemDetailFetchService.init)
        let interactor = RMGalleryItemDetailInteractor(serviceLocator: serviceLocator, artObject: artModel)
        
        galleryItemDetailView.router = router
        galleryItemDetailView.presenter = presenter
        presenter.view = galleryItemDetailView
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return galleryItemDetailView
    }
}
