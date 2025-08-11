//
//
//  LoginUseCase.swift
//  CoinRankingCryptoDomain
//
//  Created by Nicholas Wambui on 9/22/24.
//

import Foundation
import RxSwift

public class SaveCoinsUUIDListUseCase: SaveCoinsUseCaseProtocol {
    private let homeRepository: HomeRepositoryProtocol

    public init(_ homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    public func saveCoinsUUids(_ uuids: [String]) {
        homeRepository.saveCoinsUUids(uuids)
    }
    
    public func getCoinsUUids() -> [String] {
        return homeRepository.getCoinsUUids()
    }

}
