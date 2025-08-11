//
//
//  ServicesRemoteDataSource.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wambui on 9/18/24.
//

import CoinRankingCryptoDomain
import RxSwift

class HomeRemoteDataSource: BaseRemoteDataSource {
    func getCoinsList(_ limit: Int,
                      _ offset: Int,
                      _ orderBy: String = "marketCap",
                      _ orderDirection: String = "desc") -> Single<CoinMarkets>
    {
        return requestCoins(limit, offset, orderBy, orderDirection)
            .map { response, _ in
                guard let body = response.body else {
                    throw SBErrors.genericError
                }
                return body.toDomainModel()
            }
    }

    func getCoinsUUIDList(_ uuids: [String],
                          _ limit: Int,
                          _ offset: Int,
                          _ orderBy: String = "marketCap",
                          _ orderDirection: String = "desc") -> Single<CoinMarkets>
    {
        return requestCoinsUuid(uuids, limit, offset, orderBy, orderDirection)
            .map { response, _ in
                guard let body = response.body else {
                    throw SBErrors.genericError
                }
                return body.toDomainModel()
            }
    }

    func getCoinDetails(_ uuid: String, _ timePeriod: String) -> Single<Coin> {
        return requestCoinDetails(uuid, timePeriod)
            .map { response, _ in
                guard let body = response.body else {
                    throw SBErrors.genericError
                }
                return body.toDomainModel()
            }
    }

    private func requestCoins(_ limit: Int, _ offset: Int, _ orderBy: String, _ orderDirection: String) -> Single<(GenericResponse<CoinsDataResponse>, HTTPURLResponse)> {
        let params: [String: Any] = [
            "limit": limit,
            "offset": offset,
            "orderBy": orderBy,
            "orderDirection": orderDirection
        ]
        let urlRequest = URLRequest(.coins, .get, params)
        return apiRequest(urlRequest)
    }

    private func requestCoinsUuid(_ uuids: [String], _ limit: Int, _ offset: Int, _ orderBy: String, _ orderDirection: String) -> Single<(GenericResponse<CoinsDataResponse>, HTTPURLResponse)> {
        let params: [String: Any] = [
            "uuids[]": uuids,
            "limit": limit,
            "offset": offset,
            "orderBy": orderBy,
            "orderDirection": orderDirection
        ]
        let urlRequest = URLRequest(.coins, .get, params)
        return apiRequest(urlRequest)
    }

    private func requestCoinDetails(_ uuid: String, _ timePeriod: String) -> Single<(GenericResponse<CoinDetailsResponse>, HTTPURLResponse)> {
        let params: [String: Any] = [
            "timePeriod": timePeriod
        ]
        let urlRequest = URLRequest(.coinDetails, .get, params, uuid)
        return apiRequest(urlRequest)
    }
}
