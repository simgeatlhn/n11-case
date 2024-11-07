//
//  ProductDetailContractor.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import Foundation

protocol ProductDetailViewInputs: AnyObject {
    func displayProductDetails(_ product: ProductDetailEntity)
    func showError(_ error: Error)
    func showLoadingIndicator(_ show: Bool)
}

protocol ProductDetailPresenterInput: AnyObject {
    func viewDidLoad()
}

protocol ProductDetailInteractorInput: AnyObject {
    func fetchProductDetail(productId: Int)
}

protocol ProductDetailInteractorOutput: AnyObject {
    func fetchedProductDetail(result: Result<ProductDetailEntity, Error>)
}

protocol ProductDetailRouterInput: AnyObject {
    func navigateBackToHome()
}
