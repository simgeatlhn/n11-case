//
//  StarRatingView.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import UIKit
import SnapKit

class StarRatingView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeUICoordinate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        makeUICoordinate()
    }
    
    private func setupUI() {
        addSubview(starsStackView)
        addSubview(rateLabel)
    }
}

extension StarRatingView {
    func configure(rate: Double) {
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
        rateLabel.text = String(format: "%.1f", rate)
    }
}

extension StarRatingView {
    func makeUICoordinate() {
        starsStackView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(starsStackView.snp.trailing).offset(4)
            make.centerY.equalTo(starsStackView)
            make.trailing.equalToSuperview()
        }
    }
}
