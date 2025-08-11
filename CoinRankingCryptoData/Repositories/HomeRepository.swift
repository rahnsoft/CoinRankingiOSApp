//
//  HomeRepository.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//

import CoinRankingCryptoDomain
import RxSwift

class HomeRepository: HomeRepositoryProtocol {
    private let localDefaultsDataSource: LocalDefaultsDataSource
    private let homeRemoteDataSource: HomeRemoteDataSource
    
    init(localDefaultsDataSource: LocalDefaultsDataSource = LocalDefaultsDataSource(),
         homeRemoteDataSource: HomeRemoteDataSource = HomeRemoteDataSource()) {
        self.localDefaultsDataSource = localDefaultsDataSource
        self.homeRemoteDataSource = homeRemoteDataSource
    }

    func getCoinsList(_ limit: Int,
                      _ offset: Int,
                      _ orderBy: String,
                      _ orderDirection: String) -> Single<CoinMarkets>
    {
        return homeRemoteDataSource.getCoinsList(limit, offset, orderBy, orderDirection)
    }

    func getCoinsUUIDList(_ uuids: [String],
                          _ limit: Int,
                          _ offset: Int,
                          _ orderBy: String,
                          _ orderDirection: String) -> Single<CoinMarkets>
    {
        return homeRemoteDataSource.getCoinsUUIDList(uuids, limit, offset, orderBy, orderDirection)
    }

    func getCoinDetails(_ uuid: String, _ timePeriod: String) -> Single<Coin> {
        return homeRemoteDataSource.getCoinDetails(uuid, timePeriod)
    }
    
    func saveCoinsUUids(_ uuids: [String]) {
        localDefaultsDataSource.set(uuids, forKey: .coinsUUIDs)
    }
    
    func getCoinsUUids() -> [String] {
        return localDefaultsDataSource.stringArray(forKey: .coinsUUIDs) ?? []
    }
}
