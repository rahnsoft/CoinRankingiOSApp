//
//  SingleUseCaseProtocol.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import RxSwift

public protocol SingleUseCaseProtocol {
    associatedtype DomainModel
    func invoke() -> Single<DomainModel>
}
