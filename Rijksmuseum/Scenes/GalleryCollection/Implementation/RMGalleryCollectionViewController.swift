//
//  RMGalleryCollectionViewController.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import UIKit
import SnapKit

class RMGalleryCollectionViewController: RMBaseViewController, RMGalleryCollectionViewProtocol {
    var router: RMGalleryCollectionRouterProtocol?
    var presenter: RMGalleryCollectionPresenterProtocol?
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RMGalleryItemCell.self, forCellWithReuseIdentifier: "RMGalleryItemCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        title = "Gallery"
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func showGalleryCollection() {
        collectionView.reloadData()
    }
    
    func showError(_ message: String) {

    }
}

extension RMGalleryCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.sectionCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let artModel = presenter?.item(at: indexPath) else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RMGalleryItemCell", for: indexPath) as! RMGalleryItemCell
        cell.configure(with: artModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let artModel = presenter?.item(at: indexPath) else { return  .zero }
        
        let desiredWidth: CGFloat = collectionView.bounds.width - 20
        let desiredHeight: CGFloat = desiredWidth / CGFloat(artModel.headerImageRatio)
        return CGSize(width: desiredWidth, height: desiredHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let offsetThreshold = contentHeight - scrollView.bounds.height - 100 // Adjust the threshold value as needed
        
        if scrollView.contentOffset.y > offsetThreshold {
            presenter?.loadMore()
        }
    }
}
