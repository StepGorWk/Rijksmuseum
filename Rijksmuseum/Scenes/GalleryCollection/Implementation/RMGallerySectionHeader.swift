//
//  RMGallerySectionHeader.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 09.06.23.
//

import UIKit

class RMGallerySectionHeader: UICollectionReusableView {
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.distribution = .fill
        return contentStackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
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
        backgroundColor = .barColor
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        
        contentStackView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func configure(with headerTitle: String) {
        titleLabel.text = headerTitle
    }
}
