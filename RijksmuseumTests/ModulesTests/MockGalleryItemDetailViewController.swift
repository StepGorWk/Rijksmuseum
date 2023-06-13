//
//  MockGalleryItemDetailViewController.swift
//  RijksmuseumTests
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation
@testable import Rijksmuseum

class MockGalleryItemDetailViewController: RMGalleryItemDetailViewProtocol {
    func showDetails() { }
    
    func showError(_ message: String) { }
}
