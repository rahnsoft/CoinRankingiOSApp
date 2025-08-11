//
//  SplashViewModel.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import CoinRankingCryptoDomain
import Combine
import Foundation
import RxRelay

class SplashViewModel: BaseViewModel, ObservableObject {
    private var coordinator: SplashCoordinator?
    var isLoadingRelay = BehaviorRelay<Bool>(value: false)

    func setCurrentCoordinator(_ coordinator: SplashCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: CheckAuth useCase

    func checkAuth() {
        self.coordinator?.startLogin()
    }
}
