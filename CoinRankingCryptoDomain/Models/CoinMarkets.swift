//
//  Coin.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//

import Foundation

// MARK: - CoinMarkets

public struct CoinMarkets {
    public let stats: MarketStats
    public let coins: [Coin]

    public init(stats: MarketStats, coins: [Coin]) {
        self.stats = stats
        self.coins = coins
    }
}

// MARK: - Coin

public struct Coin {
    public let id: String
    public let symbol: String
    public let name: String
    public let description: String
    public let colorHex: String?
    public let iconURL: URL?
    public let websiteURL: URL?
    public let marketCap: Double?
    public let price: Double?
    public let listedAt: Date?
    public let tier: Int?
    public let change24h: Double?
    public let rank: Int?
    public let sparkline: [Double]
    public let lowVolume: Bool
    public let detailURL: URL?
    public let volume24h: Double?
    public let btcPrice: Double?
    public let contractAddresses: [String]
    public let isWrappedTrustless: Bool
    public let wrappedTo: String?
    public let supply: Supply
    public let allTimeHighPrice: String
    public init(
        id: String,
        symbol: String,
        name: String,
        description: String,
        colorHex: String?,
        iconURL: URL?,
        websiteURL: URL?,
        marketCap: Double?,
        price: Double?,
        listedAt: Date?,
        tier: Int?,
        change24h: Double?,
        rank: Int?,
        sparkline: [Double],
        lowVolume: Bool,
        detailURL: URL?,
        volume24h: Double?,
        btcPrice: Double?,
        contractAddresses: [String],
        isWrappedTrustless: Bool,
        wrappedTo: String?,
        supply: Supply,
        allTimeHighPrice: String
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.description = description
        self.colorHex = colorHex
        self.iconURL = iconURL
        self.websiteURL = websiteURL
        self.marketCap = marketCap
        self.price = price
        self.listedAt = listedAt
        self.tier = tier
        self.change24h = change24h
        self.rank = rank
        self.sparkline = sparkline
        self.lowVolume = lowVolume
        self.detailURL = detailURL
        self.volume24h = volume24h
        self.btcPrice = btcPrice
        self.contractAddresses = contractAddresses
        self.isWrappedTrustless = isWrappedTrustless
        self.wrappedTo = wrappedTo
        self.supply = supply
        self.allTimeHighPrice = allTimeHighPrice
    }
}

// MARK: - Supply

public struct Supply {
    public let confirmed: Bool
    public let supplyAt: Int
    public let circulating, total, max: String

    public init(confirmed: Bool, supplyAt: Int, circulating: String, total: String, max: String) {
        self.confirmed = confirmed
        self.supplyAt = supplyAt
        self.circulating = circulating
        self.total = total
        self.max = max
    }
}

// MARK: - MarketStats

//
//  MarketStats.swift
//  CoinRankingCrypto
//

public struct MarketStats {
    public let total: Int
    public let totalCoins: Int
    public let totalMarkets: Int
    public let totalExchanges: Int
    public let totalMarketCap: Double
    public let totalVolume24h: Double

    public init(
        total: Int,
        totalCoins: Int,
        totalMarkets: Int,
        totalExchanges: Int,
        totalMarketCap: Double,
        totalVolume24h: Double
    ) {
        self.total = total
        self.totalCoins = totalCoins
        self.totalMarkets = totalMarkets
        self.totalExchanges = totalExchanges
        self.totalMarketCap = totalMarketCap
        self.totalVolume24h = totalVolume24h
    }
}
