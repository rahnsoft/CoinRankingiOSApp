//
//  GetStartedCoordinator.swift
//  CoinRankingCrypto
//
//  Created by Nick on 08/08/25
//

import CoinRankingCryptoDependencyInjection
import UIKit
import SwiftUI

class GetStartedCoordinator {
    private let window: UIWindow?
    private var getStartedViewModel: GetStartedViewModel!
    private var navigationController: UINavigationController?
    private var getStartedView: GetStartedView!

    init(_ window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }

    func start() {
        getStartedViewModel = DependencyInjection.shared.resolve(GetStartedViewModel.self)
        getStartedViewModel.setCoordinator(self)
        getStartedView = GetStartedView(viewModel: getStartedViewModel)
        let hostingController = UIHostingController(rootView: getStartedView)
        navigationController = UINavigationController(rootViewController: hostingController)
        navigationController?.view.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func startLogin() {
        guard let window = window else { return }
    }

    func goToLogin() {
        guard let window = appWindow else { return }
        LoginCoordinator(nil,window).start()
    }


    func goToSignUp() {
        guard let window = appWindow else { return }
    }
}
