//
//  LoginUseCaseProtocol.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import RxSwift

public protocol GetCoinsListUseCaseProtocol {
    func invoke(_ limit: Int,
                _ offset: Int,
                _ orderBy: String,
                _ orderDirection: String) -> Single<CoinMarkets>
}
