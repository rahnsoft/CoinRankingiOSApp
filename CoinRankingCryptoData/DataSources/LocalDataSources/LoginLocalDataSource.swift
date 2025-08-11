//
//  LoginLocalDataSource.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//

import CoinRankingCryptoDomain
import Foundation

class LoginLocalDataSource {
    private let localSecureDefaults: LocalSecureDefaultsDataSource
    
    init() {
        localSecureDefaults = LocalSecureDefaultsDataSource()
        
        guard let plist = InfoConfigLoader.loadEnvironmentConfigPlist() else {
            sPrint("⚠️ Failed to load credentials from plist")
            return
        }
        
        guard let key = plist["COIN_RANKING_API_KEY"] as? String
        else {
            sPrint("⚠️ Failed to load credentials from plist")
            return
        }
        
        saveToken(key)
        sPrint("✅ Loaded credentials from plist")
    }
    
    func saveToken(_ token: String) {
        localSecureDefaults.set(token, forKey: .verifyToken)
    }
    
    func getToken() -> String? {
        return localSecureDefaults.string(forKey: .verifyToken)
    }
    
    func removeToken() {
        localSecureDefaults.removeObject(forKey: .verifyToken)
    }
}
