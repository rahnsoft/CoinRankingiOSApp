//
//  Container+Data.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import CoinRankingCryptoDomain
import Foundation
import Swinject

extension Container {
    public func registerDataDependencies() {
        registerRepositories()
    }

    private func registerRepositories() {
        register(HomeRepositoryProtocol.self) { _ in
            HomeRepository()
        }
    }
}

extension Container {
    public func registerDataTestDependencies() {
        registerTestRepositories()
    }

    // MARK: Use Cases DI

    private func registerTestRepositories() {
        register(HomeRepositoryProtocol.self) { _ in
            HomeRepository()
        }
    }
}
