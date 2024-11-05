//
//  HomeInteractor.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation
import Alamofire

class HomeInteractor: HomeInteractorInput {
    
    weak var output: HomeInteractorOutputs?
    
    func fetchProductsData(url: String) {
        AF.request(url, method: .get).validate().responseDecodable(of: ResponseData.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.output?.fetchedProductsData(result: .success(data))
            case .failure(let error):
                self?.output?.fetchedProductsData(result: .failure(error))
            }
        }
    }
}



