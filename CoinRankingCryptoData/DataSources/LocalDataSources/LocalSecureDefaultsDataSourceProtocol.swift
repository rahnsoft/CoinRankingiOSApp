//
//  LocalSecureDefaultsDataSourceProtocol.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wambui on 9/19/24.
//

import Foundation

protocol LocalSecureDefaultsDataSourceProtocol {
    func set(_ value: Data, forKey defaultName: LocalDefaults)
    func set(_ value: String, forKey defaultName: LocalDefaults)
    func set(_ value: Bool, forKey defaultName: LocalDefaults)
    func setCustomObject<T: Codable>(_ value: T, forKey defaultName: LocalDefaults)
    func string(forKey key: LocalDefaults) -> String?
    func bool(forKey key: LocalDefaults) -> Bool
    func data(forKey key: LocalDefaults) -> Data?
    func customObject<T: Codable>(forKey key: LocalDefaults) -> T?
    func removeObject(forKey defaultName: LocalDefaults)
}
