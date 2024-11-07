//
//  HomeContractor.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

protocol HomeViewPresenterInput: AnyObject {
    func viewDidLoad()
    func didSelectProduct(withId productId: Int)
    func searchProducts(with query: String)
}

protocol HomeInteractorInput: AnyObject {
    func fetchProductsData(page: Int)
    func searchProducts(with query: String)
}

protocol HomeInteractorOutputs: AnyObject {
    func fetchedProductsData(result: Result<ResponseData, Error>)
    func filteredProductsData(_ products: [ProductEntity])
}

protocol HomeViewInputs: AnyObject {
    func reloadData(responseData: ResponseData)
    func showError(_ error: Error)
    func updateFilteredProducts(_ products: [ProductEntity])
}

protocol HomeRouterInput: AnyObject {
    func navigateToProductDetail(with productId: Int)
}

