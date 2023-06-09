//
//  RMBaseViewController.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 08.06.23.
//

import UIKit

class RMBaseViewController: UIViewController {
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }
}
