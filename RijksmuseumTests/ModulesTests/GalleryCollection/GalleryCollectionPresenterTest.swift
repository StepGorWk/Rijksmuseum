//
//  GalleryCollectionPresenterTest.swift
//  RijksmuseumTests
//
//  Created by Gor Stepanyan on 12.06.23.
//

import XCTest
@testable import Rijksmuseum

final class GalleryCollectionPresenterTest: XCTestCase {
    private var galleryCollectionView: RMGalleryCollectionViewProtocol?
    private var galleryCollectionRouter: RMGalleryCollectionRouterProtocol?
    private var galleryCollectionPresenter: (RMGalleryCollectionPresenterProtocol & RMGalleryCollectionPresenterInputProtocol)?
    private var galleryCollectionInteractor: RMGalleryCollectionInteractorProtocol?
    
    internal override func setUp() {
        super.setUp()
        
        let view = MockGalleryCollectionViewController()
        let presenter = RMGalleryCollectionPresenter()
        let router = RMGalleryCollectionRouter(view: view)
        let serviceLocator = ServiceLocator()
        serviceLocator.registerServices(RMGalleryCollectionFetchServiceProtocol.self, initializer: MockGalleryCollectionFetchService.init)
        let interactor = RMGalleryCollectionInteractor(serviceLocator: serviceLocator)
        
        presenter.view = view
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        galleryCollectionView = view
        galleryCollectionRouter = router
        galleryCollectionPresenter = presenter
        galleryCollectionInteractor = interactor
    }
    
    func test() {
        galleryCollectionInteractor?.fetchData()
        
        let snapshot = galleryCollectionPresenter?.snapshot()
        XCTAssert(snapshot?.numberOfItems != 0)
        
        let item = galleryCollectionPresenter?.item(at: IndexPath(row: 0, section: 0))
        XCTAssert(item != nil)
    }
}
