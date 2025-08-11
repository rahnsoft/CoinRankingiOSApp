//
//  UIColor+Data.swift
//  CoinRankingCryptoData
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import UIKit

// MARK: - color hex

/// to be able to access color codes in hex to use
extension UIColor {
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }

    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = String(hex.dropFirst())
        }

        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)

        var _red: UInt32!, _green: UInt32!, _blue: UInt32!
        switch hexWithoutSymbol.count {
        case 3: // #RGB
            _red = ((hexInt >> 4) & 0xF0 | (hexInt >> 8) & 0x0F)
            _green = ((hexInt >> 0) & 0xF0 | (hexInt >> 4) & 0x0F)
            _blue = ((hexInt << 4) & 0xF0 | hexInt & 0x0F)
        case 6: // #RRGGBB
            _red = (hexInt >> 16) & 0xFF
            _green = (hexInt >> 8) & 0xFF
            _blue = hexInt & 0xFF
        default:
            // TODO: ERROR
            break
        }

        self.init(
            red: CGFloat(_red) / 255,
            green: CGFloat(_green) / 255,
            blue: CGFloat(_blue) / 255,
            alpha: alpha
        )
    }
}
