//
//  HomeInteractor.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

class HomeInteractor: HomeInteractorInput {
    
    var output: HomeInteractorOutputs?
    var allProducts: [ProductEntity] = []
    var sponsoredProducts: [SponsoredProductEntity] = []
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared) {
        self.networkService = networkService
    }
    
    func fetchProductsData(page: Int) {
        fetchPageData(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleFetchedData(data, page: page)
            case .failure(let error):
                self.output?.fetchedProductsData(result: .failure(error))
            }
        }
    }
    
    private func fetchPageData(page: Int, completion: @escaping (Result<ResponseData, Error>) -> Void) {
        guard let url = ProductConstant.listingURL(page: page) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        networkService.fetchData(from: url, completion: completion)
    }
    
    private func handleFetchedData(_ data: ResponseData, page: Int) {
        if page == 1, let sponsoredProducts = data.sponsoredProducts {
            self.sponsoredProducts = sponsoredProducts
        }
        allProducts.append(contentsOf: data.products)
        
        if let nextPage = data.nextPage, let nextPageInt = Int(nextPage) {
            fetchProductsData(page: nextPageInt)
        } else {
            outputFinalData(data)
        }
    }
    
    private func outputFinalData(_ data: ResponseData) {
        let responseData = ResponseData(
            page: data.page,
            nextPage: data.nextPage,
            publishedAt: data.publishedAt,
            sponsoredProducts: sponsoredProducts,
            products: allProducts
        )
        output?.fetchedProductsData(result: .success(responseData))
    }
    
    func searchProducts(with query: String) {
        let filteredProducts = query.isEmpty ? allProducts : allProducts.filter { $0.title.lowercased().contains(query.lowercased()) }
        output?.filteredProductsData(filteredProducts)
    }
}
