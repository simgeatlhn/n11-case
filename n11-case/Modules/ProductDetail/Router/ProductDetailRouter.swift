//
//  ProductDetailRouter.swift
//  n11-case
//
//  Created by simge on 6.11.2024.
//

import UIKit

class ProductDetailRouter: ProductDetailRouterInput {
    
    weak var viewController: UIViewController?
    
    static func createModule(productId: Int) -> UIViewController {
        let view = ProductDetailViewController()
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter()
        let presenter = ProductDetailPresenter(view: view, interactor: interactor, router: router, productId: productId)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateBackToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

