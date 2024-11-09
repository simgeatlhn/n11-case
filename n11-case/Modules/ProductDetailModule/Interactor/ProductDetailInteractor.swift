//
//  ProductDetailInteractor.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import Foundation

class ProductDetailInteractor: ProductDetailInteractorInput {
    
    weak var output: ProductDetailInteractorOutput?
    
    func fetchProductDetail(productId: Int) {
        guard let url = ProductConstant.productDetailURL(productId: productId) else {
            output?.fetchedProductDetail(result: .failure(NetworkError.invalidURL))
            return
        }
        
        NetworkManager.shared.fetchData(from: url) { [weak self] (result: Result<ProductDetailEntity, Error>) in
            switch result {
            case .success(let productDetail):
                self?.output?.fetchedProductDetail(result: .success(productDetail))
            case .failure(let error):
                self?.output?.fetchedProductDetail(result: .failure(error))
            }
        }
    }
}


