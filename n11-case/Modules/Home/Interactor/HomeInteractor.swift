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
    private var allProducts: [ProductEntity] = []
    
    func fetchProductsData(page: Int) {
        guard let url = ProductConstant.listingURL(page: page) else {
            output?.fetchedProductsData(result: .failure(NetworkError.invalidURL))
            return
        }
        
        NetworkManager.shared.fetchData(from: url) { [weak self] (result: Result<ResponseData, Error>) in
            switch result {
            case .success(let data):
                self?.allProducts = data.products
                self?.output?.fetchedProductsData(result: .success(data))
            case .failure(let error):
                self?.output?.fetchedProductsData(result: .failure(error))
            }
        }
    }
    
    func searchProducts(with query: String) {
        if query.isEmpty {
            output?.filteredProductsData(allProducts) // Arama kutusu boşsa tüm ürünleri gösteririz
        } else {
            let filteredProducts = allProducts.filter { product in
                product.title.lowercased().contains(query.lowercased())
            }
            output?.filteredProductsData(filteredProducts)
        }
    }
}


