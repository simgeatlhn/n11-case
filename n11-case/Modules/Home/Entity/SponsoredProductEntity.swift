//
//  SponsoredProductEntity.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

struct ResponseData: Codable {
    let page: String
    let nextPage: String?
    let publishedAt: String?
    let sponsoredProducts: [SponsoredProductEntity]?
    let products: [ProductEntity]
    
    enum CodingKeys: String, CodingKey {
        case page
        case nextPage
        case publishedAt = "published_at"
        case sponsoredProducts
        case products
    }
}

struct SponsoredProductEntity: Codable {
    let id: Int
    let title: String
    let imageUrl: String
    let price: Double
    let instantDiscountPrice: Double
    let rate: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "image"
        case price
        case instantDiscountPrice
        case rate
    }
}
