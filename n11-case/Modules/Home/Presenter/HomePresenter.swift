//
//  HomePresenter.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import Foundation

class HomePresenter: HomeViewPresenterInput{
    
    let interactor: HomeInteractor
    let view: HomeViewInputs
    
    init(interactor: HomeInteractor, view: HomeViewInputs) {
        self.interactor = interactor
        self.view = view
    }
    
    func viewDidLoad() {
    
    }
    
    func fetchProducts() {
        
    }
    
    func fetchSponsoredProducts() {
        
    }
}
