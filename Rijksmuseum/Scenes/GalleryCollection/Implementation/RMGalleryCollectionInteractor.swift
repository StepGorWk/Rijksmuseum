//
//  RMGalleryCollectionInteractor.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

class RMGalleryCollectionInteractor: RMPaginationInteractor, RMGalleryCollectionInteractorProtocol {
    private let service: RMGalleryCollectionFetchServiceProtocol?
    private var task: URLSessionDataTask?
    weak var presenter: RMGalleryCollectionInteractorOutputProtocol?
    var artObjectSections: [RMArtObjectSection] = []
   
    required init(serviceLocator: ServiceLocatorProtocol) {
        service = serviceLocator.getService(RMGalleryCollectionFetchServiceProtocol.self)
    }
    
    var isFetching: Bool { task?.state == .running }
    
    func fetchData() {
        let request = RMPaginationRequest(p: 0, ps: pageSize)
       getArtModels(request: request)
    }
    
    override func fetchNextPage() {
        if !isFetching {
            let request = RMPaginationRequest(p: currentPage + 1, ps: pageSize)
            getArtModels(request: request)
        }
    }
    
    private func getArtModels(request: RMPaginationRequest) {
         task = service?.getGalleryCollection(request: request, completion: { [weak self] (result:(Result<RMGalleryCollectionModel, Error>)) in
            guard let self = self else { return }
            switch result {
                case .success(let data):
                    self.totalCount = data.count
                    if request.p == 0 {
                        self.artObjectSections = data.toArtObjectSections()
                    } else {
                        let objectSections = data.toArtObjectSections()
                        objectSections.forEach { artObjectSection in
                            if let section = self.artObjectSections.first(where: { $0.header == artObjectSection.header }) {
                                section.items.append(contentsOf: artObjectSection.items)
                            } else {
                                self.artObjectSections.append(artObjectSection)
                            }
                        }
                        self.currentPage += 1
                    }
                    self.fetchedItems = self.artObjectSections.compactMap { $0.items.count }.reduce(0, +)
                    self.presenter?.didFetchData()
                case .failure(let error):
                    self.presenter?.didFail(with: error)
            }
        })
    }
}
