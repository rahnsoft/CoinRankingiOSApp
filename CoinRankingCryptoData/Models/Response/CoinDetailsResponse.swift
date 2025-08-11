//
//  CoinDetailsResponse.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//

import Foundation
import CoinRankingCryptoDomain

struct CoinDetailsResponse: BaseDataModel, Codable {
    let coin: CoinsResponse?
    
    enum CodingKeys: String, CodingKey {
        case coin
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coin = try container.decodeIfPresent(CoinsResponse.self, forKey: .coin)
    }
    
    func toDomainModel() -> Coin {
        return (coin ?? CoinsResponse()).toDomainModel()
    }
}
