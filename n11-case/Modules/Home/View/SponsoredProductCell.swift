//
//  SponsoredProductCell.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

class SponsoredProductCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
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
        view.backgroundColor = UIColor(red: 232/255, green: 244/255, blue: 253/255, alpha: 1)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let extraDiscountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bolt.fill")
        imageView.tintColor = .blue
        return imageView
    }()
    
    private let extraDiscountLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepette Ek İndirim"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .blue
        return label
    }()
    
    private let freeShippingLabel: UILabel = {
        let label = UILabel()
        label.text = "Ücretsiz Kargo"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeUICordinate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with product: SponsoredProductEntity) {
        if let url = URL(string: product.imageUrl) {
            imageView.kf.setImage(with: url)
        }
        
        titleLabel.text = product.title
        let priceText = String(format: "%.2f TL", product.price)
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: priceText)
        attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceLabel.attributedText = attributeString
        instantDiscountPriceLabel.text = String(format: "%.2f TL", product.instantDiscountPrice)
        
        if let rate = product.rate {
            rateLabel.text = "\(rate)"
            setupStars(rate: rate)
        } else {
            rateLabel.text = ""
            setupStars(rate: 0)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cartIconContainerView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(instantDiscountPriceLabel)
        contentView.addSubview(extraDiscountView)
        contentView.addSubview(freeShippingLabel)
        contentView.addSubview(starsStackView)
        contentView.addSubview(rateLabel)
        
        cartIconContainerView.addSubview(cartIconImageView)
        extraDiscountView.addSubview(extraDiscountImageView)
        extraDiscountView.addSubview(extraDiscountLabel)
    }
    
    private func setupStars(rate: Double) {
        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 1...5 {
            let starImageView = UIImageView()
            starImageView.translatesAutoresizingMaskIntoConstraints = false
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
}

extension SponsoredProductCell {
    private func makeUICordinate() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(160)
            make.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        cartIconContainerView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.top.equalTo(priceLabel)
            make.bottom.equalTo(instantDiscountPriceLabel)
            make.width.equalTo(32)
        }
        
        cartIconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(cartIconContainerView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        instantDiscountPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.equalTo(priceLabel)
        }
        
        extraDiscountView.snp.makeConstraints { make in
            make.top.equalTo(instantDiscountPriceLabel.snp.bottom).offset(8)
            make.trailing.equalTo(extraDiscountLabel.snp.trailing).offset(4)
            make.leading.equalTo(cartIconContainerView)
            make.height.equalTo(24)
        }
        
        extraDiscountImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(12)
        }
        
        extraDiscountLabel.snp.makeConstraints { make in
            make.leading.equalTo(extraDiscountImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.centerY.equalToSuperview()
        }
        
        freeShippingLabel.snp.makeConstraints { make in
            make.top.equalTo(extraDiscountView.snp.bottom).offset(12)
            make.leading.equalTo(cartIconContainerView)
        }
        
        starsStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalTo(imageView)
            make.height.equalTo(16)
            make.leading.greaterThanOrEqualTo(imageView.snp.leading)
            make.trailing.lessThanOrEqualTo(imageView.snp.trailing)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starsStackView)
            make.leading.equalTo(starsStackView.snp.trailing).offset(4)
        }
    }
}


