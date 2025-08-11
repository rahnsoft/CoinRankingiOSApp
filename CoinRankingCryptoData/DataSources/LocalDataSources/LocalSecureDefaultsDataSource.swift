//
//  LocalSecureDefaultsDataSource.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wambui on 9/19/24.
//

import KeychainSwift
import Foundation

class LocalSecureDefaultsDataSource: LocalSecureDefaultsDataSourceProtocol {
    private let keychain = KeychainSwift()

    func set(_ value: Data, forKey defaultName: LocalDefaults) {
        keychain.set(value, forKey: defaultName.rawValue)
    }

    func set(_ value: String, forKey defaultName: LocalDefaults) {
        keychain.set(value, forKey: defaultName.rawValue)
    }

    func set(_ value: Bool, forKey defaultName: LocalDefaults) {
        keychain.set(value, forKey: defaultName.rawValue)
    }

    func customObject<T>(forKey key: LocalDefaults) -> T? where T: Decodable, T: Encodable {
        if let data = keychain.getData(key.rawValue) {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {}
        }
        return nil
    }

    func setCustomObject<T: Codable>(_ value: T, forKey defaultName: LocalDefaults) {
        let encodedData = try! JSONEncoder().encode(value)
        keychain.set(encodedData, forKey: defaultName.rawValue)
    }

    func string(forKey key: LocalDefaults) -> String? {
        return keychain.get(key.rawValue)
    }

    func bool(forKey key: LocalDefaults) -> Bool {
        return keychain.getBool(key.rawValue) ?? false
    }

    func data(forKey key: LocalDefaults) -> Data? {
        return keychain.getData(key.rawValue)
    }

    func removeObject(forKey defaultName: LocalDefaults) {
        keychain.delete(defaultName.rawValue)
    }
}
