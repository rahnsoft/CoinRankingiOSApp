//
//  LocalDefaultsDataSourceProtocol.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import Foundation

protocol LocalDefaultsDataSourceProtocol {
    func set(_ value: Any?, forKey defaultName: LocalDefaults)
    func setCustomObject<T: Codable>(_ value: T, forKey defaultName: LocalDefaults)
    func string(forKey key: LocalDefaults) -> String?
    func bool(forKey key: LocalDefaults) -> Bool
    func integer(forKey key: LocalDefaults) -> Int?
    func double(forKey key: LocalDefaults) -> Double?
    func object(forKey key: LocalDefaults) -> Any?
    func customObject<T: Codable>(forKey key: LocalDefaults) -> T?
    func removeObject(forKey defaultName: LocalDefaults)
}

enum LocalDefaults: String {
    case verifyToken = "VerifyToken"
    case coinsUUIDs = "CoinsUUIDs"
}
