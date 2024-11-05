//
//  HomeViewController.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private var sponsoredProductsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SponsoredProductCell")
        return collectionView
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 10
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        return pageControl
    }()
    
    private var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView
    }()
    
    lazy var presenter: HomePresenter = .init(interactor: HomeInteractor(), view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(sponsoredProductsCollectionView)
        view.addSubview(pageControl)
        view.addSubview(productsCollectionView)
        
        makeUICordinate()
        setupDelegates()
    }
    
    private func setupDelegates() {
        sponsoredProductsCollectionView.delegate = self
        sponsoredProductsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
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
            return 10
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sponsoredProductsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsoredProductCell", for: indexPath)
            cell.backgroundColor = .gray
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
            cell.backgroundColor = .gray
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sponsoredProductsCollectionView {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            let width = (collectionView.frame.width - 8) / 2
            return CGSize(width: width, height: width + 50)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == sponsoredProductsCollectionView {
            updatePageControl()
        }
    }
}

extension HomeViewController: HomeViewInputs {

}

//MARK: UI Draw
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
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

