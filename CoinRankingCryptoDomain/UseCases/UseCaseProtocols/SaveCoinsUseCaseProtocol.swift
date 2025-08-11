//
//  GetCoinDetailsUseCaseProtocol.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation

import RxSwift

public protocol SaveCoinsUseCaseProtocol {
    func saveCoinsUUids(_ uuids: [String])
    
    func getCoinsUUids() -> [String]
}
