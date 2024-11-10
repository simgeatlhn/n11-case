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
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .customPurpleColor
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let searchContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.customGrayColor.cgColor
        view.backgroundColor = .customGrayColor
        return view
    }()
    
    private let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ürünleri ara.."
        textField.borderStyle = .none
        textField.returnKeyType = .search
        textField.backgroundColor = .clear
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.accessibilityIdentifier = "searchTextField"
        return textField
    }()
    
    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "searchLogo")
        imageView.clipsToBounds = true
        return imageView
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
        collectionView.accessibilityIdentifier = "sponsoredProductsCollectionView"
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
        collectionView.accessibilityIdentifier = "productsCollectionView"
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
        view.addSubview(loadingIndicator)
        view.addSubview(searchContainerView)
        view.addSubview(sponsoredProductsCollectionView)
        view.addSubview(pageControl)
        view.addSubview(productsCollectionView)
        searchContainerView.addSubview(topImageView)
        searchContainerView.addSubview(searchIconImageView)
        searchContainerView.addSubview(searchTextField)
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
            let width = (collectionView.frame.width - 16) / 2
            return CGSize(width: width, height: width + 150)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == sponsoredProductsCollectionView {
            updatePageControl()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sponsoredProductsCollectionView {
            guard indexPath.row < sponsoredProducts.count else {
                print("Sponsored product index out of range")
                return
            }
            let sponsoredProduct = sponsoredProducts[indexPath.row]
            presenter.didSelectProduct(withId: sponsoredProduct.id)
        } else if collectionView == productsCollectionView {
            guard indexPath.row < products.count else {
                print("Product index out of range")
                return
            }
            let product = products[indexPath.row]
            presenter.didSelectProduct(withId: product.id)
        }
    }
}

extension HomeViewController: HomeViewInputs {
    func reloadData(responseData: ResponseData) {
        if let sponsoredProducts = responseData.sponsoredProducts, !sponsoredProducts.isEmpty {
            self.sponsoredProducts = sponsoredProducts
        }
        self.products = responseData.products
        DispatchQueue.main.async { [weak self] in
            self?.sponsoredProductsCollectionView.reloadData()
            self?.productsCollectionView.reloadData()
            self?.pageControl.numberOfPages = self?.sponsoredProducts.count ?? 0
        }
    }
    
    func showLoadingIndicator(_ show: Bool) {
        if show {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
            }
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

extension HomeViewController {
    func makeUICordinate() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        searchContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        topImageView.snp.makeConstraints { make in
            make.leading.equalTo(searchContainerView).offset(8)
            make.centerY.equalTo(searchContainerView)
            make.width.height.equalTo(100)
        }
        
        searchIconImageView.snp.makeConstraints { make in
            make.trailing.equalTo(searchContainerView).inset(8)
            make.centerY.equalTo(searchContainerView)
            make.width.height.equalTo(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(topImageView.snp.trailing).offset(2)
            make.trailing.equalTo(searchIconImageView.snp.leading).offset(-2)
            make.centerY.equalTo(searchContainerView)
            make.height.equalTo(searchContainerView)
        }
        
        sponsoredProductsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchContainerView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(sponsoredProductsCollectionView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
