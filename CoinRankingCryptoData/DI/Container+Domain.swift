//
//  Container+Domain.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import CoinRankingCryptoDomain
import Swinject

extension Container {
    public func registerDomainDependencies() {
        registerUseCases()
    }

    // MARK: Use Cases DI

    // swiftlint:disable function_body_length
    private func registerUseCases() {
        register(GetCoinsListUseCase.self) { resolver in
            guard let repository = resolver.resolve(HomeRepositoryProtocol.self) else {
                fatalError("Failed to resolve HomeRepositoryProtocol")
            }
            let useCase = GetCoinsListUseCase(repository)
            return useCase
        }

        register(GetCoinsUUIDListUseCase.self) { resolver in
            guard let repository = resolver.resolve(HomeRepositoryProtocol.self) else {
                fatalError("Failed to resolve HomeRepositoryProtocol")
            }
            let useCase = GetCoinsUUIDListUseCase(repository)
            return useCase
        }

        register(GetCoinDetailsUseCase.self) { resolver in
            guard let repository = resolver.resolve(HomeRepositoryProtocol.self) else {
                fatalError("Failed to resolve HomeRepositoryProtocol")
            }
            let useCase = GetCoinDetailsUseCase(repository)
            return useCase
        }
        
        register(SaveCoinsUUIDListUseCase.self) { resolver in
            guard let repository = resolver.resolve(HomeRepositoryProtocol.self) else {
                fatalError("Failed to resolve HomeRepositoryProtocol")
            }
            let useCase = SaveCoinsUUIDListUseCase(repository)
            return useCase
        }
    }
}
