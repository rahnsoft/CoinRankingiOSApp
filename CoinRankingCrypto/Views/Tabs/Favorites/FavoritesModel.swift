//
//  HomeViewModel.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//

import CoinRankingCryptoDomain
import RxRelay
import RxSwift
import UIKit

class FavoritesModel: BaseViewModel {
    private var coordinator: FavoritesCoordinator?
    private var getCoinsUUIDListUseCase: GetCoinsUUIDListUseCaseProtocol
    private var getCoinDetailsUseCase: GetCoinDetailsUseCaseProtocol
    private var saveCoinsUUIDListUseCase: SaveCoinsUseCaseProtocol
    var coinsList = BehaviorRelay(value: [Coin]())
    var favCoinsUuids = BehaviorRelay(value: [String]())
    private var currentOffset = 0
    private let limit = 20
    var isLoadingMore = false
    var hasMoreData = true
    var coinListDataSource = BehaviorRelay(value: [HomeUITableViewCell.UIModel]())
    var selectedCoin = BehaviorRelay<Coin?>(value: nil)
    var dataDetails = BehaviorRelay<[(String, String)]?>(value: nil)

    func setCoordinator(_ coordinator: FavoritesCoordinator) {
        self.coordinator = coordinator
    }

    init(_ getCoinsUUIDListUseCase: GetCoinsUUIDListUseCaseProtocol,
         _ getCoinDetailsUseCase: GetCoinDetailsUseCaseProtocol,
         _ saveCoinsUUIDListUseCase: SaveCoinsUseCaseProtocol)
    {
        self.getCoinsUUIDListUseCase = getCoinsUUIDListUseCase
        self.getCoinDetailsUseCase = getCoinDetailsUseCase
        self.saveCoinsUUIDListUseCase = saveCoinsUUIDListUseCase
    }
    
    func saveCoinsUUIDs(_ uuids: [String]) {
        saveCoinsUUIDListUseCase.saveCoinsUUids(uuids)
        successRelay.accept("Favorite unsaved successfully.")
    }
    
    func getCoinsUUIDs() -> [String] {
        let uuids = saveCoinsUUIDListUseCase.getCoinsUUids()
        favCoinsUuids.accept(uuids)
        return uuids
    }

    func getCoinsUuids(_ reset: Bool = false) {
       let uuids = getCoinsUUIDs()
        guard !isLoadingMore, !uuids.isEmpty  else { return }
        if reset {
            currentOffset = 0
            hasMoreData = true
        }

        guard hasMoreData else {
            loadingRelay.accept(false)
            return
        }

        isLoadingMore = true
        loadingRelay.accept(true)

        getCoinsUUIDListUseCase
            .invoke(favCoinsUuids.value,
                    limit,
                    currentOffset,
                    "marketCap",
                    "desc")
            .subscribe(onSuccess: { [weak self] coinsMarket in
                guard let self = self else { return }
                let coins = coinsMarket.coins
                if reset {
                    self.coinsList.accept(coins)
                } else {
                    self.coinsList.accept(self.coinsList.value + coins)
                }
                self.currentOffset += self.limit

                if self.coinsList.value.count >= 100 || coins.count < self.limit {
                    self.hasMoreData = false
                }

                self.coinListDataSource.accept(
                    self.coinsList.value.map { coin in
                        HomeUITableViewCell.UIModel(
                            id: coin.id,
                            iconURL: coin.iconURL,
                            title: coin.symbol.uppercased(),
                            subtitle: coin.name,
                            price: coin.price?.formattedNumber() ?? "-",
                            performance: coin.change24h ?? 0.0,
                        )
                    }
                )

                self.isLoadingMore = false
                self.loadingRelay.accept(false)
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.isLoadingMore = false
                self.loadingRelay.accept(false)
                self.handleError(error) {
                    self.getCoinsUuids(reset)
                }
            })
            .disposed(by: disposeBag)
    }

    func getCoinDetails(_ coinId: String) {
        loadingRelay.accept(true)
        getCoinDetailsUseCase
            .invoke(coinId, "24h")
            .subscribe(onSuccess: { [weak self] coin in
                guard let self = self else { return }
                self.selectedCoin.accept(coin)
                self.dataDetails.accept([
                    ("MarketCap", (coin.marketCap ?? 0).formattedNumber()),
                    ("Circulating supply", coin.supply.circulating),
                    ("Max supply", coin.supply.max),
                    ("Total supply", coin.supply.total),
                    ("All-time high", coin.allTimeHighPrice),
                    ("Ranking: #", (coin.rank ?? 0).formattedNumber())
                ])
                self.loadingRelay.accept(false)
                self.goToCoinDetails()
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.loadingRelay.accept(false)
                self.handleError(error) {
                    self.getCoinDetails(coinId)
                }
            })
            .disposed(by: disposeBag)
    }

    func goToCoinDetails() {
        if let selectedCoin = selectedCoin.value {
            coordinator?.goToCoinDetails(selectedCoin, dataDetails.value ?? [])
        }
    }
}
