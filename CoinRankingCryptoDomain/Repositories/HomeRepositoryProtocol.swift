//
//
//  HomeRepositoryProtocol.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/18/24.
//

import Foundation
import RxSwift

public protocol HomeRepositoryProtocol {
    func getCoinsList(_ limit: Int,
                      _ offset: Int,
                      _ orderBy: String,
                      _ orderDirection: String) -> Single<CoinMarkets>

    func getCoinsUUIDList(_ uuids: [String],
                          _ limit: Int,
                          _ offset: Int,
                          _ orderBy: String,
                          _ orderDirection: String) -> Single<CoinMarkets>

    func getCoinDetails(_ uuid: String, _ timePeriod: String) -> Single<Coin>

    func saveCoinsUUids(_ uuids: [String])

    func getCoinsUUids() -> [String]
}
