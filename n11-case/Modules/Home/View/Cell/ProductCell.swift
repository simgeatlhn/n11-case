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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let starRatingView = StarRatingView()
    
    private let cartIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customPurpleColor
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let cartIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cart.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let instantDiscountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let extraDiscountView: UIView = {
        let view = UIView()
        view.backgroundColor = .customYellowColor
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let extraDiscountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bolt.fill")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let extraDiscountLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepette Ek İndirim"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    private let extraDiscountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: ProductEntity) {
        titleLabel.text = product.title
        sellerNameLabel.text = product.sellerName
        starRatingView.configure(rate: product.rate ?? 0)
        if let url = URL(string: product.imageUrl) {
            imageView.kf.setImage(with: url)
        }
        let formattedPrice = PriceFormatter.formatPrice(product.price)
        let attributeString = NSMutableAttributedString(string: formattedPrice)
        attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        priceLabel.attributedText = attributeString
        instantDiscountPriceLabel.text = PriceFormatter.formatPrice(product.instantDiscountPrice ?? product.price)
        if let instantDiscountPrice = product.instantDiscountPrice, instantDiscountPrice >= 100 {
            let discountedPrice = PriceFormatter.formatPrice(max(instantDiscountPrice - 100, 0))
            extraDiscountPriceLabel.text = discountedPrice
            extraDiscountView.isHidden = false
        } else {
            extraDiscountView.isHidden = true
        }
    }

    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starRatingView)
        contentView.addSubview(cartIconContainerView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(instantDiscountPriceLabel)
        contentView.addSubview(extraDiscountView)
        contentView.addSubview(sellerNameLabel)
        cartIconContainerView.addSubview(cartIconImageView)
        extraDiscountView.addSubview(extraDiscountImageView)
        extraDiscountView.addSubview(extraDiscountLabel)
        extraDiscountView.addSubview(extraDiscountPriceLabel)
    }
}

extension ProductCell {
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(4)
        }
        
        starRatingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.height.equalTo(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(starRatingView.snp.bottom).offset(4)
            make.leading.equalTo(cartIconContainerView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-4)
        }
        
        instantDiscountPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.equalTo(priceLabel)
        }
        
        cartIconContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalTo(priceLabel)
            make.bottom.equalTo(instantDiscountPriceLabel)
            make.width.equalTo(30)
        }
        
        cartIconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        extraDiscountView.snp.makeConstraints { make in
            make.top.equalTo(instantDiscountPriceLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(4)
        }
        
        extraDiscountImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
            make.width.height.equalTo(16)
        }
        
        extraDiscountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(extraDiscountImageView)
            make.leading.equalTo(extraDiscountImageView.snp.trailing).offset(4)
        }
        
        extraDiscountPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(extraDiscountLabel.snp.bottom).offset(4)
            make.leading.equalTo(extraDiscountImageView)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(extraDiscountView.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
}
