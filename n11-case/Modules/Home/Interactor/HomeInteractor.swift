//
//  HomeInteractor.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

class HomeInteractor: HomeInteractorInput {
    
    weak var output: HomeInteractorOutputs?
    var allProducts: [ProductEntity] = []
    var sponsoredProducts: [SponsoredProductEntity] = []
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared) {
        self.networkService = networkService
    }
    
    func fetchProductsData(page: Int) {
        guard let url = ProductConstant.listingURL(page: page) else {
            output?.fetchedProductsData(result: .failure(NetworkError.invalidURL))
            return
        }
        
        networkService.fetchData(from: url) { [weak self] (result: Result<ResponseData, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if page == 1, let sponsoredProducts = data.sponsoredProducts {
                    self.sponsoredProducts = sponsoredProducts
                }
                
                self.allProducts.append(contentsOf: data.products)
                if let nextPage = data.nextPage, let nextPageInt = Int(nextPage) {
                    self.fetchProductsData(page: nextPageInt)
                } else {
                    let responseData = ResponseData(
                        page: data.page,
                        nextPage: data.nextPage,
                        publishedAt: data.publishedAt,
                        sponsoredProducts: self.sponsoredProducts,
                        products: self.allProducts
                    )
                    self.output?.fetchedProductsData(result: .success(responseData))
                }
            case .failure(let error):
                self.output?.fetchedProductsData(result: .failure(error))
            }
        }
    }
    
    func searchProducts(with query: String) {
        if query.isEmpty {
            output?.filteredProductsData(allProducts)
        } else {
            let filteredProducts = allProducts.filter { product in
                product.title.lowercased().contains(query.lowercased())
            }
            output?.filteredProductsData(filteredProducts)
        }
    }
}
