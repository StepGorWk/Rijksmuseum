//
//  String.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 08.06.23.
//

import Foundation
import UIKit

extension String {
    func height(for font: UIFont, constrainedWidth: CGFloat) -> CGFloat {
        let labelWidth = constrainedWidth
        let labelSize = NSString(string: self).size(withAttributes: [.font: font])
        
        return ceil(labelSize.height)
    }
}
