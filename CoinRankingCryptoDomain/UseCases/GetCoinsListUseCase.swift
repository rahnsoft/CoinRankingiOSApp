//
//  LoginUseCase.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import RxSwift

public class GetCoinsListUseCase: GetCoinsListUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol

    public init(_ homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    public func invoke(_ limit: Int,
                       _ offset: Int,
                       _ orderBy: String,
                       _ orderDirection: String) -> Single<CoinMarkets>
    {
        return homeRepository.getCoinsList(limit, offset, orderBy, orderDirection)
    }
}
