//
//  TabBarCoordinator.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 24/05/2024.
//

import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import UIKit

// MARK: - TabBarCoordinator

class TabBarCoordinator {
    private let window: UIWindow
    private var tabController: TabViewController?

    init(_ window: UIWindow) {
        self.window = window
    }

    func start(_ selectedIndex: Int? = nil) {
        let tabViewModel = DependencyInjection.shared.resolve(TabBarViewModel.self)
        tabViewModel.setCoordinator(self)
        tabController = TabViewController(tabViewModel)
        tabController?.viewControllers = tabBarControllers()
        tabController?.selectedIndex = selectedIndex ?? 0
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }

    func tabBarControllers() -> [UIViewController] {
        let homeVc = HomeCoordinator().homeViewController()
        homeVc.tabBarItem.tag = 0
        let favoritesVc = FavoritesCoordinator().favoritesViewController()
        favoritesVc.tabBarItem.tag = 1
        return [homeVc, favoritesVc]
    }
}
