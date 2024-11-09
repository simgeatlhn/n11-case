//
//  SplashViewController.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    var presenter: SplashPresenterInput!
    
    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "n11")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customPurpleColor
        setupUI()
        makeUICordinate()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(splashImageView)
    }
}

extension SplashViewController {
    func makeUICordinate() {
        splashImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.5)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.5)
        }
    }
}
