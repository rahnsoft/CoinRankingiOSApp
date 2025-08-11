//
//  LoginCoordinator.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wambui on 10/29/24.
//

import Foundation
import CoinRankingCryptoDomain
import UIKit
import CoinRankingCryptoDependencyInjection

class LoginCoordinator {
    private var loginViewModel: LoginViewModel!
    private var navigationController: UINavigationController?
    private var loginViewController: LoginViewController!
    private var window: UIWindow?

    init(_ navigationController: UINavigationController? = nil, _ window: UIWindow? = nil) {
        self.navigationController = navigationController
        self.window = window
    }

    func start() {
        loginViewModel = DependencyInjection.shared.resolve(LoginViewModel.self)
        loginViewModel.setCoordinator(self)
        if let window = window {
            loginViewController = LoginViewController(loginViewModel)
            navigationController = UINavigationController(rootViewController: loginViewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        } else {
            loginViewController = LoginViewController(loginViewModel)
            navigationController?.pushViewController(loginViewController, animated: true)
        }
    }

    func goToRegister() {
    }

    func goToOTP(_ password: String) {
        guard let window = appWindow, let navigationController = navigationController else { return }
        OTPCoordinator(window, navigationController, true, password).start()
    }
}
