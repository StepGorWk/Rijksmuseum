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
    private let titleLabel: UILabel = {
          let label = UILabel()
          // Additional label setup code
          return label
      }()
      
      private let imageView: UIImageView = {
          let imageView = UIImageView()
          // Additional image view setup code
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
          contentView.addSubview(titleLabel)
          contentView.addSubview(imageView)
          
          titleLabel.snp.makeConstraints { make in
              make.leading.equalToSuperview().offset(8)
              make.trailing.equalToSuperview().inset(8)
              make.top.equalToSuperview().offset(8)
          }
          
          imageView.snp.makeConstraints { make in
              make.leading.equalToSuperview()
              make.trailing.equalToSuperview()
              make.top.equalTo(titleLabel.snp.bottom).offset(8)
              make.bottom.equalToSuperview().inset(8)
          }
      }
    
      func configure(with artObject: RMArtModel) {
          titleLabel.text = artObject.title
          guard let imageUrl = URL(string: artObject.headerImage.url) else { return }
          
          imageView.sd_setImage(with: imageUrl)
          // Load image asynchronously using artObject.imageURL and set it to imageView
      }
}
