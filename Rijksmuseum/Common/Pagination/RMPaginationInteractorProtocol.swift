//
//  RMPaginationInteractorProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

protocol RMPaginationInteractorProtocol: AnyObject {
    var currentPage: Int { get }
    var fetchedItems: Int { get }
    var totalCount: Int { get }
    var pageSize: Int { get }
    var haveItemToFetch: Bool { get }
   
    func fetchNextPage()
}
