//
//  Object+Data.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import RealmSwift

extension Object {
    @objc func save(_ update: Bool) {
        do {
            let realm = RealmFactory().realmInstance()
            realm.beginWrite()
            realm.add(self, update: update ? .all : .error)
            try realm.commitWrite()
        } catch {
            sPrint("Can't save realm Object", error)
        }
    }

    func deleteFromRealm() {
        do {
            let realm = RealmFactory().realmInstance()
            realm.beginWrite()
            realm.delete(self)
            try realm.commitWrite()
        } catch {}
    }

    func deleteAllFromRealm() {
        do {
            let realm = RealmFactory().realmInstance()
            realm.beginWrite()
            realm.deleteAll()
            try realm.commitWrite()
        } catch {}
    }
}
