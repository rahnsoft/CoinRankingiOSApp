//
//  LoginUseCase.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import RxSwift

public class GetCoinDetailsUseCase: GetCoinDetailsUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol
    
    public init(_ homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    public func invoke(_ uuid: String, _ timePeriod: String) -> Single<Coin> {
        return homeRepository.getCoinDetails(uuid, timePeriod)
    }
}
