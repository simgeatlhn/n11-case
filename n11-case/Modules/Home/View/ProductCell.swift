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
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let cartIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
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
        view.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0.5)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let extraDiscountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bolt.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let extraDiscountLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepette Ek İndirim"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private let extraDiscountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
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
        
        if let url = URL(string: product.imageUrl) {
            imageView.kf.setImage(with: url)
        }
        
        if let rate = product.rate {
            rateLabel.text = "\(rate)"
            setupStars(rate: rate)
        } else {
            rateLabel.text = ""
            setupStars(rate: 0)
        }
        
        // Fiyat Ayarlama
        if let instantDiscountPrice = product.instantDiscountPrice {
            let originalPriceText = String(format: "%.2f TL", product.price)
            let attributeString = NSMutableAttributedString(string: originalPriceText)
            attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
            priceLabel.attributedText = attributeString
            
            instantDiscountPriceLabel.text = String(format: "%.2f TL", instantDiscountPrice)
            
            if instantDiscountPrice >= 100 {
                let discountedPrice = instantDiscountPrice - 100
                extraDiscountPriceLabel.text = String(format: "%.2f TL", max(discountedPrice, 0))
                extraDiscountView.isHidden = false
            } else {
                extraDiscountPriceLabel.text = String(format: "%.2f TL", instantDiscountPrice)
                extraDiscountView.isHidden = false
            }
        } else {
            let priceText = String(format: "%.2f TL", product.price)
            priceLabel.text = priceText
            instantDiscountPriceLabel.text = priceText
            extraDiscountPriceLabel.text = "—"
            extraDiscountView.isHidden = true
        }
    }
    
    
    private func setupStars(rate: Double) {
        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 1...5 {
            let starImageView = UIImageView()
            if rate >= Double(index) {
                starImageView.image = UIImage(systemName: "star.fill")
            } else if rate >= Double(index) - 0.5 {
                starImageView.image = UIImage(systemName: "star.lefthalf.fill")
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
            starImageView.tintColor = .systemYellow
            starImageView.contentMode = .scaleAspectFit
            starsStackView.addArrangedSubview(starImageView)
            
            starImageView.snp.makeConstraints { make in
                make.width.height.equalTo(12)
            }
        }
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starsStackView)
        contentView.addSubview(rateLabel)
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
        
        starsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
            make.height.equalTo(16)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starsStackView)
            make.leading.equalTo(starsStackView.snp.trailing).offset(4)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(starsStackView.snp.bottom).offset(4)
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
