//
//  Container+App.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import CoinRankingCryptoData
import CoinRankingCryptoDomain
import Swinject

extension Container {
    func registerAppDependencies() {
        registerViewModelDependencies()
    }

    // swiftlint:disable function_body_length
    private func registerViewModelDependencies() {
        register(SplashViewModel.self) { resolver in
            let viewModel = SplashViewModel(
            )
            return viewModel
        }

        register(GetStartedViewModel.self) { resolver in
            let viewModel = GetStartedViewModel(
            )
            return viewModel
        }

        register(LoginViewModel.self) { resolve in
            let viewModel = LoginViewModel(
            )
            return viewModel
        }

        register(OTPViewModel.self) { resolve in
            let viewModel = OTPViewModel(
            )
            return viewModel
        }

        register(TabBarViewModel.self) { _ in
            TabBarViewModel()
        }

        register(FavoritesModel.self) { resolve in
            let getCoinsListUseCase = resolve.resolve(GetCoinsUUIDListUseCase.self)!
            let getCoinDetailsUseCase = resolve.resolve(GetCoinDetailsUseCase.self)!
            let saveCoinsUUIDListUseCase = resolve.resolve(SaveCoinsUUIDListUseCase.self)!
            let viewModel = FavoritesModel(
                getCoinsListUseCase,
                getCoinDetailsUseCase,
                saveCoinsUUIDListUseCase
            )
            return viewModel
        }

        register(HomeViewModel.self) { resolve in
            let getCoinsListUseCase = resolve.resolve(GetCoinsListUseCase.self)!
            let getCoinDetailsUseCase = resolve.resolve(GetCoinDetailsUseCase.self)!
            let saveCoinsUUIDListUseCase = resolve.resolve(SaveCoinsUUIDListUseCase.self)!
            let viewModel = HomeViewModel(
                getCoinsListUseCase,
                getCoinDetailsUseCase,
                saveCoinsUUIDListUseCase
            )
            return viewModel
        }
    }
}
