//
//  Constant.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

struct ProductConstant {
    static let baseURL = "https://private-d3ae2-n11case.apiary-mock.com"
    
    // Endpoint Paths
    struct Endpoints {
        static let listing = "/listing/"
        static let productDetail = "/product"
    }
    
    // URL Builders
    static func listingURL(page: Int) -> URL? {
        let urlString = "\(baseURL)\(Endpoints.listing)\(page)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return nil
        }
        return url
    }
    
    static func productDetailURL(productId: Int) -> URL? {
        var components = URLComponents(string: "\(baseURL)\(Endpoints.productDetail)")
        components?.queryItems = [URLQueryItem(name: "productId", value: "\(productId)")]
        return components?.url
    }
}
