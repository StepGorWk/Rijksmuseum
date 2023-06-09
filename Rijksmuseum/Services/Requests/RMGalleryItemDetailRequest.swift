//
//  RMGalleryItemDetailRequest.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

class RMGalleryItemDetailRequest: RMBaseRequest {
    let objectNumber: String
    
    init(objectNumber: String) {
        self.objectNumber = objectNumber
    }
}
