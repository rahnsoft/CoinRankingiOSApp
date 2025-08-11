//
//  HomeCoordinator.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wambui on 11/25/24.
//

import CoinRankingCryptoDependencyInjection
import RxRelay
import RxSwift
import UIKit

class HomeCoordinator {
    private var homeViewModel: HomeViewModel!
    private var navigationController: UINavigationController?
    private var baseViewController: BaseViewController?
    var disposeBag = DisposeBag()
    
    init(_ navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func homeViewController() -> UIViewController {
        homeViewModel = DependencyInjection.shared.resolve(HomeViewModel.self)
        homeViewModel.setCoordinator(self)
        let homeViewController = HomeViewController(homeViewModel)
        homeViewController.tabBarItem = UITabBarItem(Strings.commonMarkets.localized(),
                                                     "Home_Tab_icon",
                                                     "Home_Tab_icon", true)
        navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController?.navigationBar.isTranslucent = false
        return navigationController ?? UIViewController()
    }
    
    func goToCoinDetails(_ viewModel: HomeViewModel) {
        guard let navigationController = navigationController else { return }
        let coinDetailsViewController = CoinDetailsViewController(viewModel)
        coinDetailsViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(coinDetailsViewController, animated: true)
    }
}
