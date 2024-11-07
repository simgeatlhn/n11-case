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
    
    static func createModule() -> UIViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
    func navigateToMainApp() {
        let tabBarController = TabBarController()
        if let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

