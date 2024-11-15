//
//  HomePresenter.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

class HomePresenter: HomeViewPresenterInput {
    weak var view: HomeViewInputs?
    var interactor: HomeInteractorInput
    var router: HomeRouterInput?
    
    init(view: HomeViewInputs, interactor: HomeInteractorInput, router: HomeRouterInput?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showLoadingIndicator(true)
        interactor.fetchProductsData(page: 1)
    }
    
    func didSelectProduct(withId productId: Int) {
        router?.navigateToProductDetail(with: productId)
    }
    
    func searchProducts(with query: String) {
        view?.showLoadingIndicator(true)
        interactor.searchProducts(with: query)
    }
}

extension HomePresenter: HomeInteractorOutputs {
    func fetchedProductsData(result: Result<ResponseData, Error>) {
        view?.showLoadingIndicator(false)
        switch result {
        case .success(let responseData):
            view?.reloadData(responseData: responseData)
        case .failure(let error):
            view?.showError(error)
        }
    }
    
    func filteredProductsData(_ products: [ProductEntity]) {
        view?.showLoadingIndicator(false)
        view?.updateFilteredProducts(products)
    }
}
