//
//  HomeViewController.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    var presenter: HomeViewPresenterInput!
    private var sponsoredProducts: [SponsoredProductEntity] = []
    private var products: [ProductEntity] = []
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Search "
        textField.borderStyle = .none
        textField.returnKeyType = .search
        textField.backgroundColor = .customGrayColor
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 16)
        let iconView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconView.tintColor = .gray
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 8, y: 0, width: 16, height: 16)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 16))
        paddingView.addSubview(iconView)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    
    private lazy var sponsoredProductsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(SponsoredProductCell.self, forCellWithReuseIdentifier: "SponsoredProductCell")
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        return pageControl
    }()
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        makeUICordinate()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(sponsoredProductsCollectionView)
        view.addSubview(pageControl)
        view.addSubview(productsCollectionView)
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    private func setupDelegates() {
        sponsoredProductsCollectionView.delegate = self
        sponsoredProductsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    @objc private func searchTextChanged() {
        guard let searchText = searchTextField.text else { return }
        presenter.searchProducts(with: searchText)
    }
    
    private func updatePageControl() {
        let visibleRect = CGRect(origin: sponsoredProductsCollectionView.contentOffset, size: sponsoredProductsCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let indexPath = sponsoredProductsCollectionView.indexPathForItem(at: visiblePoint) {
            pageControl.currentPage = indexPath.row
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sponsoredProductsCollectionView {
            return sponsoredProducts.count
        } else {
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sponsoredProductsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsoredProductCell", for: indexPath) as? SponsoredProductCell else {
                return UICollectionViewCell()
            }
            let product = sponsoredProducts[indexPath.row]
            cell.configure(with: product)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
                return UICollectionViewCell()
            }
            let product = products[indexPath.row]
            cell.configure(with: product)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sponsoredProductsCollectionView {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            let width = (collectionView.frame.width - 8) / 2
            return CGSize(width: width, height: width + 150)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == sponsoredProductsCollectionView {
            updatePageControl()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        presenter.didSelectProduct(withId: product.id)
    }
}

extension HomeViewController: HomeViewInputs {
    func reloadData(responseData: ResponseData) {
        self.sponsoredProducts = responseData.sponsoredProducts
        self.products = responseData.products
        DispatchQueue.main.async { [weak self] in
            self?.sponsoredProductsCollectionView.reloadData()
            self?.productsCollectionView.reloadData()
            self?.pageControl.numberOfPages = self?.sponsoredProducts.count ?? 0
        }
    }
    
    func updateFilteredProducts(_ products: [ProductEntity]) {
        self.products = products
        DispatchQueue.main.async { [weak self] in
            self?.productsCollectionView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: UI Draw
extension HomeViewController {
    func makeUICordinate() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        sponsoredProductsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(sponsoredProductsCollectionView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
}

