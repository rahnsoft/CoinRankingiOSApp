//
//  NSNumber+App.swift
//  CoinRankingCrytpo
//
//  Created by Nick on 05/08/2025.
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
