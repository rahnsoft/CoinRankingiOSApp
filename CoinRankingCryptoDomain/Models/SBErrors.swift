//
//  SBErrors.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation

public enum SBErrors: Error {
    case genericError
    case internetError
    case timeout
    case fileNotFound
    case countryNotSupported
    case localUserNotFound
    case dataBaseError
    case apiErrorForJanus(status: String, reason: String)
    case apiError(code: Int, message: String, reason: String, dict: [String: Any]?)
    case retryError(message: String, retryAction: () -> Void)
    case elementNotFound
    case cityNotSupported
    case unauthorized
    case pendingTopUpRequest
    case userNotFound
    case invalidPin
    case userBlacklisted
    case merchantClosed
    case merchantDisabled
    case invalidRefreshToken
    case invalidUser
    case parseData
    case isInValid
    case pinExpired
    case invalidVerificationCode
    case insufficientFunds
    case inActiveCard
    case maxSumTotalExceeded(String)
    case minTimeLimitBreached(String)
    case maxTransactionVolumeExceeded(String)
    case maxAmountBreached(String)
    case minAmountBreached(String)
    case maxBalanceBreached(String)
    case minBalanceBreached(String)
    case exceededLimit(message: String)
    case exceededOTPTrialLimit(message: String)

    // MARK: Public

    public enum Reason: String {
        case invalidCredentials = "invalid_credentials"
        case invalidPassword = "invalid_password"
    }

    // MARK: Internal

    public func errorMessage() -> String {
        switch self {
        case let .apiError(_, message, _, _):
            return message
        case let .retryError(message, _):
            return message
        case let .maxSumTotalExceeded(message):
            return message
        case let .minTimeLimitBreached(message):
            return message
        case let .maxTransactionVolumeExceeded(message):
            return message
        case let .maxAmountBreached(message):
            return message
        case let .minAmountBreached(message):
            return message
        case let .maxBalanceBreached(message):
            return message
        case let .minBalanceBreached(message):
            return message
        case let .exceededLimit(messsage):
            return messsage
        case let .exceededOTPTrialLimit(message):
            return message
        default:
            return "Something went wrong. Please try again."
        }
    }
}

extension SBErrors: LocalizedError {
    public var errorDescription: String? {
        return errorMessage()
    }
}
