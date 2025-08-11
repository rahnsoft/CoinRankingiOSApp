//
//  GetStartedViewModel.swift
//  CoinRankingCrypto
//
//  Created by Nick on 08/08/2025.
//

import Foundation
import CoinRankingCryptoDomain
import RxRelay

class GetStartedViewModel: BaseViewModel,ObservableObject {
    private var coordinator: GetStartedCoordinator?

    func setCoordinator(_ coordinator: GetStartedCoordinator) {
        self.coordinator = coordinator
    }

    func startLogin() {
        coordinator?.startLogin()
    }

    func goToLogin() {
        coordinator?.goToLogin()
    }

    func goToSignUp() {
        coordinator?.goToSignUp()
    }
}
