//
//  TabBarViewModel.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 24/05/2024.
//

import Foundation
import RxCocoa
 import CoinRankingCryptoDomain

class TabBarViewModel: BaseViewModel {
    private var coordinator: TabBarCoordinator?

    func setCoordinator(_ coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
    }
}
