//
//  OTPCoordinator.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 13/05/2024.
//

import Foundation
import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import UIKit

class OTPCoordinator {
    private var navigationController: UINavigationController?
    private var otpViewController: OTPViewController!
    private var window: UIWindow?
    private var isLogin: Bool = false
    private var password: String = ""

    init(_ window: UIWindow? = nil, _ navigationController: UINavigationController, _ isLogin: Bool = false, _ password: String = "") {
        self.window = window
        self.navigationController = navigationController
        self.isLogin = isLogin
        self.password = password
    }

    // MARK: Start the OTP process

    func start() {
        let otpViewModel = DependencyInjection.shared.resolve(OTPViewModel.self)
        otpViewModel.setCoordinator(self)
        otpViewModel.setIsLogin(isLogin)
        otpViewModel.setPassCode(password)
        otpViewController = OTPViewController(otpViewModel)
        navigationController?.pushViewController(otpViewController, animated: true)
    }

    func goToLogin() {
        guard let navigationController = navigationController else { return }
        LoginCoordinator(navigationController).start()
    }

    func goToSetPassword() {
    }

    func goToHomeScreen() {
        guard let window = appWindow else { return }
        let tabCoordinator = TabBarCoordinator(window)
        tabCoordinator.start()
    }
}
