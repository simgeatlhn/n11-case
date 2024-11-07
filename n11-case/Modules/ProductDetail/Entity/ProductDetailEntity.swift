//
//  ProductDetailEntity.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import Foundation

struct ProductDetailEntity: Codable {
    let title: String
    let description: String
    let images: [String]
    let price: Double
    let instantDiscountPrice: Double
    let rate: Double?
    let sellerName: String
}

