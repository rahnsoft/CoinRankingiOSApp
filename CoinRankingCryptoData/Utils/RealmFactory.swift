//
//  RealmFactory.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//



import Foundation
import RealmSwift

class RealmFactory {
    func realmInstance() -> Realm {
        Realm.Configuration.defaultConfiguration = realmConfigs()
        do {
            return try Realm()
        } catch {
            Realm.Configuration.defaultConfiguration = migrate()
            return try! Realm()
        }
    }

    private func realmConfigs() -> Realm.Configuration {
        var currentRealmVersion = Realm.Configuration.defaultConfiguration.schemaVersion
        if currentRealmVersion == 0 {
            currentRealmVersion = 22
        }
        return Realm.Configuration(
            schemaVersion: currentRealmVersion,
            migrationBlock: { _, _ in
            }
        )
    }

    private func migrate() -> Realm.Configuration {
        let newVersion: UInt64 = 22
        return Realm.Configuration(schemaVersion: newVersion, migrationBlock: { _, _ in
        }, deleteRealmIfMigrationNeeded: true)
    }
}
