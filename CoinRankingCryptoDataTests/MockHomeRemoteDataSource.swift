//
//  MockHomeRemoteDataSource.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//

import RxSwift
@testable import CoinRankingCryptoData
@testable import CoinRankingCryptoDomain

final class MockHomeRemoteDataSource: HomeRemoteDataSource {
    var getCoinsListCalled = false
    var getCoinsUUIDListCalled = false
    var getCoinDetailsCalled = false
    
    var stubbedCoinsMarkets: CoinMarkets!
    var stubbedCoin: Coin!

    override func getCoinsList(_ limit: Int, _ offset: Int, _ orderBy: String, _ orderDirection: String) -> Single<CoinMarkets> {
        getCoinsListCalled = true
        return Single.just(stubbedCoinsMarkets)
    }

    override func getCoinsUUIDList(_ uuids: [String], _ limit: Int, _ offset: Int, _ orderBy: String, _ orderDirection: String) -> Single<CoinMarkets> {
        getCoinsUUIDListCalled = true
        return Single.just(stubbedCoinsMarkets)
    }

    override func getCoinDetails(_ uuid: String, _ timePeriod: String) -> Single<Coin> {
        getCoinDetailsCalled = true
        return Single.just(stubbedCoin)
    }
}

final class MockLocalDefaultsDataSource: LocalDefaultsDataSource {
    var savedUUIDs: [String]?
    var returnedUUIDs: [String]?

    override func set(_ value: [String], forKey key: UserDefaultsKey) {
        savedUUIDs = value
    }

    override func stringArray(forKey key: UserDefaultsKey) -> [String]? {
        return returnedUUIDs
    }
}
