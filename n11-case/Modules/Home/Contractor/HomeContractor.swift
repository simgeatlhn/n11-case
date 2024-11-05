//
//  HomeContractor.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

protocol HomeViewInputs: AnyObject {
    func reloadData(responseData: ResponseData)
    func showError(_ error: Error)
}

protocol HomeViewPresenterInput: AnyObject {
    func viewDidLoad()
}

protocol HomeInteractorInput: AnyObject {
    func fetchProductsData(url: String)
}

protocol HomeInteractorOutputs: AnyObject {
    func fetchedProductsData(result: Result<ResponseData, Error>)
}

protocol HomeRouterInput: AnyObject {
    // Navigation
}
