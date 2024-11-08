//
//  MockHomeInteractor.swift
//  n11-caseTests
//
//  Created by simge on 8.11.2024.
//

import Foundation
@testable import n11_case

class MockHomeInteractorOutputs: HomeInteractorOutputs {
    var fetchedProductsDataCalled = false
    var fetchedResult: Result<ResponseData, Error>?
    
    var filteredProductsDataCalled = false
    var filteredProducts: [ProductEntity]?
    
    func fetchedProductsData(result: Result<ResponseData, Error>) {
        fetchedProductsDataCalled = true
        fetchedResult = result
    }
    
    func filteredProductsData(_ products: [ProductEntity]) {
        filteredProductsDataCalled = true
        filteredProducts = products
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<ResponseData, Error>?
    
    func fetchData<T>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if let result = result as? Result<T, Error> {
            completion(result)
        } else {
            completion(.failure(NetworkError.unknownError))
        }
    }
}

