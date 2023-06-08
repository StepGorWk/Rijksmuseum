//
//  RMPaginationInteractor.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

class RMPaginationInteractor: RMPaginationInteractorProtocol {
    var currentPage: Int = 0
    var totalCount: Int = 0
    var fetchedItems: Int = 0
    var pageSize: Int = 10
    var haveItemToFetch: Bool { fetchedItems == 0 || fetchedItems != totalCount }
    
    func fetchNextPage() { }
}
