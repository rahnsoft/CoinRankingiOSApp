//
//  APIEndpoint.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 09/02/2025.
//

import Foundation

enum APIEndpoint: String {
    case coins
    case coinDetails = "/coin/%@"

    var baseURL: BaseURL {
        return .default_url
    }

    // MARK: Internal

    enum BaseURL {
        case default_url
    }
}
