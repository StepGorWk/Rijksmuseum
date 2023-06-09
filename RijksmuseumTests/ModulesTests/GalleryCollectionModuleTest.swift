//
//  GalleryCollectionModuleTest.swift
//  RijksmuseumUITests
//
//  Created by Gor Stepanyan on 09.06.23.
//

import XCTest
@testable import Rijksmuseum

class GalleryCollectionModuleTest: XCTestCase {
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
    
    func test_interactor() -> Void {
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
    
    func test_presenter() -> Void {
        galleryCollectionInteractor?.fetchData()
        
        let snapshot = galleryCollectionPresenter?.snapshot()
        XCTAssert(snapshot?.numberOfItems != 0)
        
        let item = galleryCollectionPresenter?.item(at: IndexPath(row: 0, section: 0))
        XCTAssert(item != nil)
    }
}
