//
//  UIString+Data.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 06/02/2025.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return "\(prefix(1).capitalized)\(dropFirst())"
    }
}
