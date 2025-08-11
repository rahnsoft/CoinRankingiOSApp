//
//  LocalDefaultsDataSource.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import RxSwift

class LocalDefaultsDataSource: LocalDefaultsDataSourceProtocol {
    private let localDefaults = UserDefaults.standard
    func migrate() {}

    func set(_ value: Any?, forKey defaultName: LocalDefaults) {
        localDefaults.set(value, forKey: defaultName.rawValue)
    }

    func setCustomObject<T: Codable>(_ value: T, forKey defaultName: LocalDefaults) {
        let encodedData = try! JSONEncoder().encode(value)
        localDefaults.set(encodedData, forKey: defaultName.rawValue)
    }

    func string(forKey key: LocalDefaults) -> String? {
        return localDefaults.string(forKey: key.rawValue)
    }
    
    func stringArray(forKey key: LocalDefaults) -> [String]? {
        return localDefaults.stringArray(forKey: key.rawValue)
    }

    func bool(forKey key: LocalDefaults) -> Bool {
        return localDefaults.bool(forKey: key.rawValue)
    }

    func integer(forKey key: LocalDefaults) -> Int? {
        guard let integer = localDefaults.object(forKey: key.rawValue) as? Int else {
            return nil
        }
        return integer
    }

    func double(forKey key: LocalDefaults) -> Double? {
        guard let double = localDefaults.object(forKey: key.rawValue) as? Double else {
            return nil
        }
        return double
    }

    func object(forKey key: LocalDefaults) -> Any? {
        return localDefaults.object(forKey: key.rawValue)
    }

    func customObject<T: Codable>(forKey key: LocalDefaults) -> T? {
        if let data = localDefaults.data(forKey: key.rawValue) {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {}
        }
        return nil
    }

    func removeObject(forKey defaultName: LocalDefaults) {
        localDefaults.removeObject(forKey: defaultName.rawValue)
    }
}
