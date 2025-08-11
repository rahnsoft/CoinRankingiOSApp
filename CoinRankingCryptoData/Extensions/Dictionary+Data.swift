//
//  Dictionary+Data.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation

extension Dictionary {
    func toJSONString() -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: data, encoding: .utf8)
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
