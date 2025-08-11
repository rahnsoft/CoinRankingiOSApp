//
//  ConnectivityManager.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 09/02/2025.
//

import Foundation
import Reachability

public class ConnectivityManager {
    public static let shared = ConnectivityManager()

    public init() {}

    /// Using the reachability swift library, listens for connection changes
    /// at request time
    /// - Returns: Whether internet is available or not [true or false]
    public func isConnected() -> Bool {
        var connected = false
        do {
            if try Reachability().connection != .unavailable {
                connected = true
            }
        } catch {
            connected = false
        }
        return connected
    }
}
