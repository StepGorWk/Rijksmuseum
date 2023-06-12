//
//  GalleryCollectionInteractorTest.swift
//  RijksmuseumTests
//
//  Created by Gor Stepanyan on 12.06.23.
//

import XCTest
@testable import Rijksmuseum

final class GalleryCollectionInteractorTest: XCTestCase {
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
        galleryCollectionPresenter?.viewDidLoad()
        var count: Int = galleryCollectionInteractor?.artObjectSections.count ?? 0
        XCTAssert(count == 5)
        var page = galleryCollectionInteractor?.currentPage ?? 0
        XCTAssert(page == 0)
        
        galleryCollectionPresenter?.loadMore()
        count = galleryCollectionInteractor?.artObjectSections.count ?? 0
        XCTAssert(count == 9)
        page = galleryCollectionInteractor?.currentPage ?? 0
        XCTAssert(page == 1)
    }
}
