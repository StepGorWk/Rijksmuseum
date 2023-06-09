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
    
    func item(at indexPath: IndexPath) -> RMArtModel? {
        interactor?.artObjectSections[indexPath.section].items[indexPath.row]
    }
    
    func loadMore() {
        interactor?.fetchNextPage()
    }
    
    func snapshot() -> ArtModelSnapshot {
        var snapshot = ArtModelSnapshot()
        guard let artObjectSections = interactor?.artObjectSections else { return snapshot }
        
        snapshot.appendSections(artObjectSections.compactMap { $0.header })
        
        for artObjectSection in artObjectSections {
            snapshot.appendItems(artObjectSection.items, toSection: artObjectSection.header)
        }
        return snapshot
    }
}

extension RMGalleryCollectionPresenter: RMGalleryCollectionPresenterInputProtocol {

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
