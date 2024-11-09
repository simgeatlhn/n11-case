//
//  SplashContractor.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import Foundation

protocol SplashViewInput: AnyObject {
 
}

protocol SplashPresenterInput: AnyObject {
    func viewDidLoad()
}

protocol SplashInteractorInput: AnyObject {
    func startTimer()
}

protocol SplashInteractorOutput: AnyObject {
    func timerDidFinish()
}

protocol SplashRouterInput: AnyObject {
    func navigateToMainApp()
}
