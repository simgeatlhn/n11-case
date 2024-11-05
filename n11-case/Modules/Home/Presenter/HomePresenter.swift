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
        (self.interactor as? HomeInteractor)?.output = self
    }
    
    func viewDidLoad() {
        interactor.fetchProductsData(url: ProductConstant.BASE_URL)
    }
}

extension HomePresenter: HomeInteractorOutputs {
    func fetchedProductsData(result: Result<ResponseData, Error>) {
        switch result {
        case .success(let responseData):
            view?.reloadData(responseData: responseData)
        case .failure(let error):
            view?.showError(error)
        }
    }
}

