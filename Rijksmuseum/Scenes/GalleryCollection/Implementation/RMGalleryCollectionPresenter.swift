//
//  RMGalleryCollectionPresenter.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

class RMGalleryCollectionPresenter: RMGalleryCollectionPresenterProtocol {
    var interactor: RMGalleryCollectionInteractorProtocol?
    weak var view: RMGalleryCollectionViewProtocol?
    
    var isFetching: Bool { interactor?.isFetching ?? false }
    var haveItemToFetch: Bool { interactor?.haveItemToFetch ?? false }
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func sectionCount() -> Int {
        interactor?.artObjectSections.count ?? 0
    }
    
    func numberOfItems(section: Int) -> Int {
        interactor?.artObjectSections[section].items.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> RMArtModel? {
        interactor?.artObjectSections[indexPath.section].items[indexPath.row]
    }
    
    func loadMore() {
        interactor?.fetchNextPage()
    }
}

extension RMGalleryCollectionPresenter: RMGalleryCollectionInteractorOutputProtocol {

    func didFetchData() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showGalleryCollection()
        }
    }
    
    func didFail(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showError(error.localizedDescription)
        }
    }
}
