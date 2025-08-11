//
//  Utils+Print.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 11/06/2024.
//

import Foundation

/// Global function to help print errors in debug only
///
/// - Parameter e: error
func sPrintDebugError(error: Error) {
    #if DEBUG || BETARELEASE
        debugPrint(error)
    #endif
}

/// Global function to help print  debug only
///
/// - Parameter e: error
func sPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG || BETARELEASE
        debugPrint(items, separator, terminator)
    #endif
}
