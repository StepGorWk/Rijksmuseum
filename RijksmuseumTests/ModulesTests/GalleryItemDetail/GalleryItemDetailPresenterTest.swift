//
//  GalleryItemDetailPresenterTest.swift
//  RijksmuseumTests
//
//  Created by Gor Stepanyan on 12.06.23.
//

import XCTest
@testable import Rijksmuseum

final class GalleryItemDetailPresenterTest: XCTestCase {
    private var galleryItemDetailView: RMGalleryItemDetailViewProtocol?
    private var galleryItemDetailRouter: RMGalleryItemDetailRouterProtocol?
    private var galleryItemDetailPresenter: (RMGalleryItemDetailPresenterProtocol & RMGalleryItemDetailPresenterInputProtocol)?
    private var galleryItemDetailInteractor: RMGalleryItemDetailInteractorProtocol?
    
    internal override func setUp() {
        super.setUp()
                    
        let view = MockGalleryItemDetailViewController()
        let presenter = RMGalleryItemDetailPresenter()
        let router = RMGalleryItemDetailRouter()
        let serviceLocator = ServiceLocator()
        serviceLocator.registerServices(RMGalleryItemDetailFetchServiceProtocol.self, initializer: MockGalleryItemDetailFetchService.init)
        let artObject = RMArtModel(links: RMArtModelLinks(web: "", origin: ""),
                                   id: "",
                                   objectNumber: "RP-P-OB-12.406",
                                   title: "",
                                   hasImage: false,
                                   principalOrFirstMaker: "",
                                   longTitle: "",
                                   description: "",
                                   showImage: true,
                                   permitDownload: true,
                                   webImage: nil,
                                   headerImage: nil,
                                   productionPlaces: [])
        let interactor = RMGalleryItemDetailInteractor(serviceLocator: serviceLocator, artObject: artObject)
        
        presenter.view = view
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        galleryItemDetailView = view
        galleryItemDetailRouter = router
        galleryItemDetailPresenter = presenter
        galleryItemDetailInteractor = interactor
    }
    
    func test() {
        galleryItemDetailInteractor?.fetchDetail()
        
        let title = galleryItemDetailPresenter?.title
        XCTAssertEqual(title, "The artist's mother in a cloth headdress, looking down: head only")
        
        let description = galleryItemDetailPresenter?.description
        XCTAssertEqual(description, "The artist's mother in a cloth headdress, looking down: head only, anonymous, Rembrandt van Rijn, after 1633")
    }
}
