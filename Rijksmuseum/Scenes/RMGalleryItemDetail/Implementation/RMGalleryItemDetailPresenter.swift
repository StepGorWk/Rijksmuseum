//
//  RMGalleryItemDetailPresenter.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

class RMGalleryItemDetailPresenter: RMGalleryItemDetailPresenterProtocol {
    var interactor: RMGalleryItemDetailInteractorProtocol?
    weak var view: RMGalleryItemDetailViewProtocol?
    
    var title: String? {
        interactor?.detail?.artObject.title
    }
    
    var description: String? {
        interactor?.detail?.artObject.longTitle ?? interactor?.detail?.artObject.description
    }
    
    var imageUrl: URL? {
        URL(string: interactor?.detail?.artObject.webImage?.url ?? "")
    }
    
    var imageRatio: CGFloat? {
        CGFloat(interactor?.detail?.artObject.webImage?.imageRatio ?? 1)
    }
    
    func viewDidLoad() {
        interactor?.fetchDetail()
    }
}

extension RMGalleryItemDetailPresenter: RMGalleryItemDetailPresenterInputProtocol {
    func didFetchData() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showDetails()
        }
    }
    
    func didFail(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showError(error.localizedDescription)
        }
    }
}
