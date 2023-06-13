//
//  RMGalleryItemDetailViewController.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import UIKit
import SnapKit
import SDWebImage

class RMGalleryItemDetailViewController: RMBaseViewController, RMGalleryItemDetailViewProtocol {
    enum Sizes {
        static let offset: CGFloat = 10
    }
    
    var router: RMGalleryItemDetailRouterProtocol?
    var presenter: RMGalleryItemDetailPresenterProtocol?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        view.addSubview(loadingIndicator)
        
        imageView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(Sizes.offset)
            make.right.equalToSuperview().offset(-Sizes.offset)
            make.height.equalTo(0)
        }
        
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Sizes.offset)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        loadingIndicator.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        loadingIndicator.startAnimating()
    }
    
    func showDetails() {
        loadingIndicator.stopAnimating()
        title = presenter?.title
        descriptionLabel.text = presenter?.description
        
        imageView.snp.updateConstraints { make in
            make.height.equalTo(view.bounds.width / (presenter?.imageRatio ?? 1))
        }
        
        guard let imageUrl = presenter?.imageUrl else { return }

        imageView.sd_setImage(with: imageUrl)
    }
    
    func showError(_ message: String) { }
}
