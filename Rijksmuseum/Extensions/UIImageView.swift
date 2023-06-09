//
//  UIImageView.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 08.06.23.
//

import UIKit

extension UIImageView {
    func animateImage(_ image: UIImage) {
        // Apply animation to the image view
        alpha = 0
        self.image = image
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
}
