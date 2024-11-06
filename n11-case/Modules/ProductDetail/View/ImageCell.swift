//
//  ProductDetailCollectionViewCell.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import UIKit
import Kingfisher


class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        makeUICordinate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: String) {
        if let imageUrl = URL(string: url) {
            imageView.kf.setImage(with: imageUrl)
        }
    }
}

extension ImageCell {
    func makeUICordinate() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
