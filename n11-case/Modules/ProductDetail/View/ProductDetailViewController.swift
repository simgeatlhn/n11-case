//
//  ProductDetailViewController.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import UIKit
import SnapKit

final class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenterInput!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    
    private let topRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "firsat")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "24 Ay Apple Türkiye Garantili, Aynı Gün Kargo"
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "20"
        return label
    }()
    
    private let discountIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bolt.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGreen
        label.text = "Sepette İndirim"
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let instantDiscountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "10"
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let tagIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell.badge.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tagDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Özel indirimli üründür. Bazı n11 kuponları bu üründe kullanılmayabilir."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let buyNowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hemen Al", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var imageUrls: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupDelegates()
        makeUICoordinate()
        presenter.viewDidLoad()
    }
    
    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupUI() {
        // Add scrollView and contentView
        view.addSubview(scrollView)
        contentView.addSubview(topRightImageView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(discountIcon)
        contentView.addSubview(discountLabel)
        contentView.addSubview(instantDiscountPriceLabel)
        contentView.addSubview(bottomSeparatorView)
        contentView.addSubview(tagIcon)
        contentView.addSubview(tagDescriptionLabel)
        // Add buttons directly to the main view
        view.addSubview(addToCartButton)
        view.addSubview(buyNowButton)
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        let imageUrl = imageUrls[indexPath.row]
        cell.configure(with: imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width > 0 else { return }
        
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension ProductDetailViewController: ProductDetailViewInputs {
    func displayProductDetails(_ product: ProductDetailEntity) {
        titleLabel.text = product.title
        priceLabel.text = formatPrice(product.price)
        instantDiscountPriceLabel.text = formatPrice(product.instantDiscountPrice)
        imageUrls = product.images
        pageControl.numberOfPages = imageUrls.count
        collectionView.reloadData()
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        if let formattedPrice = formatter.string(from: NSNumber(value: price)) {
            return "\(formattedPrice) TL"
        }
        return "\(price) TL"
    }
}

extension ProductDetailViewController {
    private func makeUICoordinate() {
        topRightImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).inset(16)
            make.width.height.equalTo(50) // Set your desired size
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addToCartButton.snp.top).offset(-16)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(320)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        discountIcon.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(20)
            make.bottom.equalTo(instantDiscountPriceLabel.snp.bottom)
        }
        
        discountLabel.snp.makeConstraints { make in
            make.top.equalTo(discountIcon.snp.top)
            make.leading.equalTo(discountIcon.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }
        
        instantDiscountPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(discountLabel.snp.bottom).offset(4)
            make.leading.equalTo(discountIcon.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }
        
        
        bottomSeparatorView.snp.makeConstraints { make in
            make.top.equalTo(instantDiscountPriceLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        tagIcon.snp.makeConstraints { make in
            make.top.equalTo(bottomSeparatorView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(16)
        }
        
        tagDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tagIcon)
            make.leading.equalTo(tagIcon.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(44)
            make.width.equalTo(buyNowButton)
        }
        
        buyNowButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
            make.leading.equalTo(addToCartButton.snp.trailing).offset(16)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        buyNowButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tagDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

