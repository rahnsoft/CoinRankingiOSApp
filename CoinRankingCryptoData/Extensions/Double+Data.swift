//
//  Double+Data.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 30/01/2025.
//

import Foundation

extension Double {
    var cleanDouble: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func formattedNumber() -> String {
        return NSNumber(value: self).formattedNumber()
    }
}

extension Int {
    func formattedNumber() -> String {
        return NSNumber(value: self).formattedNumber()
    }
}
