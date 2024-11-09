//
//  SplashRouter.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import UIKit
import Foundation

class SplashRouter: SplashRouterInput {
    
    weak var viewController: UIViewController?
    weak var window: UIWindow?
    
    static func createModule(window: UIWindow?) -> UIViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        router.window = window
        return view
    }
    
    func navigateToMainApp() {
        let tabBarController = TabBarController()
        guard let window = window else { return }
        window.rootViewController = tabBarController
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

