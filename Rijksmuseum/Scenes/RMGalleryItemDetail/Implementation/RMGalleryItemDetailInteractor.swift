//
//  RMGalleryItemDetailInteractor.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

class RMGalleryItemDetailInteractor: RMGalleryItemDetailInteractorProtocol {
    private let artObject: RMArtModel
    private let service: RMGalleryItemDetailFetchServiceProtocol?
    weak var presenter: RMGalleryItemDetailInteractorOutputProtocol?
    var detail: RMGalleryItemDetailModel?
    
    
    required init(serviceLocator: ServiceLocatorProtocol, artObject: RMArtModel) {
        service = serviceLocator.getService(RMGalleryItemDetailFetchServiceProtocol.self)
        self.artObject = artObject
    }
    
    func fetchDetail() {
        service?.getGalleryItemDetail(objectNumber: artObject.objectNumber, completion: { [weak self] (result:(Result<RMGalleryItemDetailModel, Error>)) in
            guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.detail = data
                    self.presenter?.didFetchData()
                case .failure(let error):
                    self.presenter?.didFail(with: error)
                }
        })
    }
}
