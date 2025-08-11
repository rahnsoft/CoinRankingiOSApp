//
//  EmptyBody.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//

import CoinRankingCryptoDomain
import Foundation

// MARK: - EmptyBody

public struct EmptyBody: Codable {}

// MARK: - GenericResponse

struct GenericResponse<T: Codable>: Codable {
    var body: T?
    var status: String?
    var type: String?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case body = "data"
        case status
        case type
        case message
    }

    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        message = try values.decodeIfPresent(String.self, forKey: .message)

        if T.self == EmptyBody.self {
            body = nil
        } else {
            body = try values.decodeIfPresent(T.self, forKey: .body)
        }
    }
}
