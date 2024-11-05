//
//  ProductCollectionViewCell.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeUICordinate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
    }
    
    private func makeUICordinate() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func configure(with product: ProductEntity) {
        titleLabel.text = product.title
        if let url = URL(string: product.imageUrl) {
            imageView.kf.setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
}


