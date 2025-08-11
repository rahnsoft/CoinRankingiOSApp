//
//
//  LoginUseCase.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import RxSwift

public class GetCoinsUUIDListUseCase: GetCoinsUUIDListUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol

    public init(_ homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    public func invoke(_ uuids: [String],
                       _ limit: Int,
                       _ offset: Int,
                       _ orderBy: String,
                       _ orderDirection: String) -> Single<CoinMarkets>
    {
        return homeRepository.getCoinsUUIDList(uuids, limit, offset, orderBy, orderDirection)
    }
}
