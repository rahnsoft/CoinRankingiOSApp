//
//  NsNumber+Data.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 30/01/2025.
//

import Foundation

extension NSNumber {
    func formattedNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        if let formattedNumber = numberFormatter.string(from: self) {
            return formattedNumber
        }
        return "\(self)"
    }
}
