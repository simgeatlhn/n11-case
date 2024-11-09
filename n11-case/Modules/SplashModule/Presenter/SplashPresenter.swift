//
//  SplashPresenter.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import Foundation

class SplashPresenter: SplashPresenterInput {
    
    var interactor: SplashInteractorInput
    var router: SplashRouterInput
    
    init(interactor: SplashInteractorInput, router: SplashRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.startTimer()
    }
}

extension SplashPresenter: SplashInteractorOutput {
    func timerDidFinish() {
        router.navigateToMainApp()
    }
}

