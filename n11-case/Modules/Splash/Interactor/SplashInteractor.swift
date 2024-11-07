//
//  SplashIntreactor.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import Foundation

class SplashInteractor: SplashInteractorInput {
    
    weak var output: SplashInteractorOutput?
    private var timer: Timer?
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { [weak self] _ in
            self?.output?.timerDidFinish()
        }
    }
}
