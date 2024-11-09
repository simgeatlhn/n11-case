//
//  PriceFormatter.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import Foundation

class PriceFormatter {
    static func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        if let formattedPrice = formatter.string(from: NSNumber(value: price)) {
            return "\(formattedPrice.trimmingCharacters(in: .whitespaces)) TL"
        }
        return String(format: "%.2f TL", price)
    }
}

