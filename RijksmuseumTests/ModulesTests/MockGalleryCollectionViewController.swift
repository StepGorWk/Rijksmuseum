//
//  MockGalleryCollectionViewController.swift
//  RijksmuseumTests
//
//  Created by Gor Stepanyan on 09.06.23.
//

import Foundation
@testable import Rijksmuseum

class MockGalleryCollectionViewController: RMGalleryCollectionViewProtocol {
    func showGalleryCollection() { }
    
    func showError(_ message: String) { }
}
