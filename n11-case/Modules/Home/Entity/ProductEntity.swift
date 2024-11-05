//
//  ProductEntity.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

struct ProductEntity: Codable {
    let id: Int
    let title: String
    let imageUrl: String
    let price: Double
    let instantDiscountPrice: Double?
    let rate: Double?
    let sellerName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "image"
        case price
        case instantDiscountPrice
        case rate
        case sellerName
    }
}
