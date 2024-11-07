//
//  ProductDetailPresenter.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import Foundation

class ProductDetailPresenter: ProductDetailPresenterInput {
    
    weak var view: ProductDetailViewInputs?
    var interactor: ProductDetailInteractorInput
    var router: ProductDetailRouterInput?
    private let productId: Int
    
    init(view: ProductDetailViewInputs, interactor: ProductDetailInteractorInput, router: ProductDetailRouterInput?, productId: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.productId = productId
    }
    
    func viewDidLoad() {
        view?.showLoadingIndicator(true) // Loading
        interactor.fetchProductDetail(productId: productId)
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutput {
    func fetchedProductDetail(result: Result<ProductDetailEntity, Error>) {
        view?.showLoadingIndicator(false)
        switch result {
        case .success(let productDetail):
            view?.displayProductDetails(productDetail)
        case .failure(let error):
            view?.showError(error)
        }
    }
}
