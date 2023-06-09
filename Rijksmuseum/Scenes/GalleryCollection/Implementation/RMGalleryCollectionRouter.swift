//
//  RMGalleryCollectionRouter.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import UIKit

class RMGalleryCollectionRouter: RMGalleryCollectionRouterProtocol {
    var navigationController: RMBaseNavigationController?
    
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
        
        let navigationController = RMBaseNavigationController(rootViewController: galleryCollectionView)
        router.navigationController = navigationController
        return navigationController
    }
    
    private weak var galleryCollectionView: RMGalleryCollectionViewProtocol?
    
    required init(view: RMGalleryCollectionViewProtocol) {
        galleryCollectionView = view
    }
    
    func navigateToDetail(with artModel: RMArtModel) {
        let detailViewController = RMGalleryItemDetailRouter.createModule(with: artModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
