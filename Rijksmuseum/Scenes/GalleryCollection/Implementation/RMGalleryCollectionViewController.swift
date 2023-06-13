//
//  RMGalleryCollectionViewController.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import UIKit
import SnapKit

class RMGalleryCollectionViewController: RMBaseViewController, RMGalleryCollectionViewProtocol {
    enum Sizes {
        static let inset: CGFloat = 10
        static let minimumLineSpacing: CGFloat = 30
        static let minimumInteritemSpacing: CGFloat = 10
        static let headerHeight: CGFloat = 30
    }
    
    var router: RMGalleryCollectionRouterProtocol?
    var presenter: RMGalleryCollectionPresenterProtocol?
    private var dataSource: UICollectionViewDiffableDataSource<String, RMArtModel>!
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Sizes.minimumLineSpacing
        flowLayout.minimumInteritemSpacing = Sizes.minimumInteritemSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        setupDataSource()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        title = "Gallery"
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        collectionView.backgroundColor = .backgroundColor
        
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        loadingIndicator.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        loadingIndicator.startAnimating()
    }
    
    private func setupCollectionView() {
        collectionView.register(for: RMGalleryItemCell.self)
        collectionView.register(for: RMGallerySectionHeader.self)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, RMArtModel>(collectionView: collectionView) { (collectionView, indexPath, artModel) -> UICollectionViewCell? in
            let cell: RMGalleryItemCell = collectionView.dequeue(indexPath)
            cell.configure(with: artModel)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView: RMGallerySectionHeader = collectionView.dequeue(kind, indexPath: indexPath)
                let headerTitle = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                headerView.configure(with: headerTitle)
                return headerView
            }
            return nil
        }
    }
    
    func showGalleryCollection() {
        loadingIndicator.stopAnimating()
        guard let snapshot = presenter?.snapshot() else { return }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Create popover presentation controller
        let popoverPresentationController = alertController.popoverPresentationController
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.sourceRect = view.bounds
        popoverPresentationController?.permittedArrowDirections = .any
        
        present(alertController, animated: true, completion: nil)
    }
}

extension RMGalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let artModel = presenter?.item(at: indexPath) else { return }
        
        router?.navigateToDetail(with: artModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let artModel = presenter?.item(at: indexPath) else { return  .zero }
        
        let width: CGFloat = (collectionView.bounds.width * 2/3) - (2 * Sizes.inset)
        let titleHeight = artModel.title.height(for: UIFont.systemFont(ofSize: 18), constrainedWidth: width) + Sizes.inset
        
        guard artModel.hasImage else { return CGSize(width: width, height: titleHeight)}
        
        let desiredHeight: CGFloat = width / CGFloat(artModel.webImage?.imageRatio ?? 1)
        return CGSize(width: width, height: desiredHeight + titleHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: Sizes.headerHeight)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if (offsetY > contentHeight - height) && !(presenter?.isFetching ?? false) {
            presenter?.loadMore()
        }
    }
}
