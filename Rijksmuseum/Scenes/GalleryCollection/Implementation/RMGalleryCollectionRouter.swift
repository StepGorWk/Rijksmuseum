//
//  RMGalleryCollectionRouter.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import UIKit

class RMGalleryCollectionRouter: RMGalleryCollectionRouterProtocol {
   
    static func createModule() -> UIViewController {
        let galleryCollectionView = RMGalleryCollectionViewController()
        let presenter = RMGalleryCollectionPresenter()
        let router = RMGalleryCollectionRouter(view: galleryCollectionView)
        let serviceLocator = ServiceLocator()
        serviceLocator.registerServices(RMGalleryCollectionFetchServiceProtocol.self, initializer: RMGalleryCollectionFetchService.init)
        let interactor = RMGalleryCollectionInteractor(serviceLocator: serviceLocator)
        
        galleryCollectionView.router = router
        galleryCollectionView.presenter = presenter
        presenter.view = galleryCollectionView
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return RMBaseNavigationController(rootViewController: galleryCollectionView)
    }
    
    private weak var galleryCollectionView: RMGalleryCollectionViewProtocol?
    
    required init(view: RMGalleryCollectionViewProtocol) {
        galleryCollectionView = view
    }
    
    func navigateToDetail() {
        
    }
}
