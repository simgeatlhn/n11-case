//
//  SplashPresenter.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import Foundation

class SplashPresenter: SplashPresenterInput {
    
    weak var view: SplashViewInput?
    var interactor: SplashInteractorInput
    var router: SplashRouterInput?
    
    init(view: SplashViewInput, interactor: SplashInteractorInput, router: SplashRouterInput?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.startTimer()
    }
}

extension SplashPresenter: SplashInteractorOutput {
    func timerDidFinish() {
        router?.navigateToMainApp()
    }
}
