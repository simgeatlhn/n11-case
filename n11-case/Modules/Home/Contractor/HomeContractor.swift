//
//  HomeContractor.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

protocol HomeInteractorOutputs {
}

protocol HomeViewInputs {
}

protocol HomeViewPresenterInput {
    func viewDidLoad()
    func fetchProducts()
    func fetchSponsoredProducts()
}
