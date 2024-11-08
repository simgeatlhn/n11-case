//
//  MockHomePresenter.swift
//  n11-caseTests
//
//  Created by simge on 8.11.2024.
//

import XCTest
@testable import n11_case

class MockHomeView: HomeViewInputs {
    var didShowLoadingIndicator = false
    var didReloadData = false
    var didUpdateFilteredProducts = false
    var didShowError = false
    
    func showLoadingIndicator(_ show: Bool) {
        didShowLoadingIndicator = show
    }
    
    func reloadData(responseData: ResponseData) {
        didReloadData = true
    }
    
    func updateFilteredProducts(_ products: [ProductEntity]) {
        didUpdateFilteredProducts = true
    }
    
    func showError(_ error: Error) {
        didShowError = true
    }
}

class MockHomeInteractor: HomeInteractorInput {
    var didFetchProductsData = false
    var didSearchProducts = false
    
    func fetchProductsData(page: Int) {
        didFetchProductsData = true
    }
    
    func searchProducts(with query: String) {
        didSearchProducts = true
    }
}

class MockHomeRouter: HomeRouterInput {
    var didNavigateToProductDetail = false
    
    func navigateToProductDetail(with productId: Int) {
        didNavigateToProductDetail = true
    }
}
