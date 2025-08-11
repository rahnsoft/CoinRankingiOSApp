//
//  HomeCoordinator.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wambui on 11/25/24.
//

import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import RxRelay
import RxSwift
import UIKit

class FavoritesCoordinator {
    private var favoritesViewModel: FavoritesModel!
    private var navigationController: UINavigationController?
    private var baseViewController: BaseViewController?
    var disposeBag = DisposeBag()

    init(_ navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func favoritesViewController() -> UIViewController {
        favoritesViewModel = DependencyInjection.shared.resolve(FavoritesModel.self)
        favoritesViewModel.setCoordinator(self)
        let favoritesViewController = FavoriteViewController(favoritesViewModel)
        favoritesViewController.tabBarItem = UITabBarItem(Strings.favourites.localized().capitalized,
                                                          "Fav_Tab_icon",
                                                          "Fav_Tab_icon", true)
        navigationController = UINavigationController(rootViewController: favoritesViewController)
        navigationController?.navigationBar.isTranslucent = false
        return navigationController ?? UIViewController()
    }

    func goToCoinDetails(_ selectedCoin: Coin, _ dataDetails: [(String, String)]) {
        guard let navigationController = navigationController else { return }
        let homeViewModel = DependencyInjection.shared.resolve(HomeViewModel.self)
        homeViewModel.selectedCoin.accept(selectedCoin)
        homeViewModel.dataDetails.accept(dataDetails)
        let coinDetailsViewController = CoinDetailsViewController(homeViewModel)
        coinDetailsViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(coinDetailsViewController, animated: true)
    }
}
