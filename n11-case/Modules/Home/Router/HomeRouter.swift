//
//  HomeRouter.swift
//  n11-case
//
//  Created by simge on 5.11.2024.
//

import UIKit

class HomeRouter: HomeRouterInput {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToProductDetail(with productId: Int) {
        let detailViewController = ProductDetailRouter.createModule(productId: productId)
        detailViewController.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
