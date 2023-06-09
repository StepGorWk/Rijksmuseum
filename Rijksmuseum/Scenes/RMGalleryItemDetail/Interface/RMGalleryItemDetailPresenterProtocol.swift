//
//  RMGalleryItemDetailPresenterProtocol.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation

typealias RMGalleryItemDetailPresenterInputProtocol = RMGalleryItemDetailInteractorOutputProtocol

protocol RMGalleryItemDetailPresenterProtocol: AnyObject {
    var title: String? { get }
    var description: String? { get }
    var imageUrl: URL? { get }
    var imageRatio: CGFloat? { get }
    
    func viewDidLoad()
}
