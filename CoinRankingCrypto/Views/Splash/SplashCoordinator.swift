//
//  SplashCoordinator.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import UIKit
import SwiftUI
import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain

class SplashCoordinator {
    private var window: UIWindow?

    private var navigationController: UINavigationController?

    required init(_ window: UIWindow?) {
        self.window = window
    }

    func start() {
        let splashViewModel = DependencyInjection.shared.resolve(SplashViewModel.self)
        splashViewModel.setCurrentCoordinator(self)
        let splashView = SplashView(viewModel: splashViewModel)
        let hostingController = UIHostingController(rootView: splashView)
        navigationController = UINavigationController(rootViewController: hostingController)
        navigationController?.view.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func startLogin() {
        guard let window = window else { return }
        GetStartedCoordinator(window).start()
    }
}
