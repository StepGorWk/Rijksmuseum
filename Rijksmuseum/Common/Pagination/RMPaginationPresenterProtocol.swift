//
//  RMPaginationPresenterProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

protocol RMPaginationPresenterProtocol: AnyObject {
    
    var isFetching: Bool { get }
    var haveItemToFetch: Bool { get }
    
    func loadMore()
}
