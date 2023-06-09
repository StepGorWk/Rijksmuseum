//
//  RMGalleryItemCell.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 08.06.23.
//

import UIKit
import SnapKit
import SDWebImage

class RMGalleryItemCell: UICollectionViewCell {
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.spacing = 10
        return contentStackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(titleLabel)
        
        contentStackView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func configure(with artObject: RMArtModel) {
        titleLabel.text = artObject.title
        guard let imageUrl = URL(string: artObject.webImage?.url ?? "") else { return }
        
        imageView.sd_imageIndicator?.startAnimatingIndicator()
        imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: .waitStoreCache) { [weak self] (image, error, cacheType, url) in
            if let image = image {
                self?.imageView.animateImage(image)
            }
        }
    }
}
