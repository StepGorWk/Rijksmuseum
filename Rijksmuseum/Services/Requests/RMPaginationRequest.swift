//
//  RMPaginationRequest.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

class RMPaginationRequest: RMBaseRequest {
    let p: Int
    let ps: Int
    let s: String
    let involvedMaker: String
    
    init(p: Int, ps: Int, s: String = "artist", involvedMaker: String = "Rembrandt van Rijn") {
        self.p = p * ps
        self.ps = ps
        self.s = s
        self.involvedMaker = involvedMaker
    }
}
