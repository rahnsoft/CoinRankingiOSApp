//
//  GetCoinDetailsUseCaseProtocol.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation

import RxSwift

public protocol GetCoinDetailsUseCaseProtocol {
    func invoke(_ uuid: String, _ timePeriod: String) -> Single<Coin>
}
