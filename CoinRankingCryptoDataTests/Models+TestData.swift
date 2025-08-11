//
//  Models+TestData.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//

import Foundation
@testable import CoinRankingCryptoDomain

// Sample Supply instance
let sampleSupply = Supply(
    confirmed: true,
    supplyAt: 1234567890,
    circulating: "18000000",
    total: "21000000",
    max: "21000000"
)

// Sample Coin instance
let sampleCoin = Coin(
    id: "bitcoin",
    symbol: "BTC",
    name: "Bitcoin",
    description: "The first decentralized cryptocurrency.",
    colorHex: "#F7931A",
    iconURL: URL(string: "https://cryptologos.cc/logos/bitcoin-btc-logo.png"),
    websiteURL: URL(string: "https://bitcoin.org"),
    marketCap: 600_000_000_000,
    price: 32000.0,
    listedAt: Date(timeIntervalSince1970: 1230768000), // 1 Jan 2009
    tier: 1,
    change24h: -2.5,
    rank: 1,
    sparkline: [31000, 31500, 32000, 31800, 32200],
    lowVolume: false,
    detailURL: URL(string: "https://coinranking.com/coin/bitcoin"),
    volume24h: 35000000000,
    btcPrice: 1.0,
    contractAddresses: [],
    isWrappedTrustless: false,
    wrappedTo: nil,
    supply: sampleSupply,
    allTimeHighPrice: "64863"
)

// Sample MarketStats instance
let sampleMarketStats = MarketStats(
    total: 5000,
    totalCoins: 2000,
    totalMarkets: 15000,
    totalExchanges: 300,
    totalMarketCap: 1_500_000_000_000,
    totalVolume24h: 100_000_000_000
)

// Sample CoinMarkets instance
let sampleCoinMarkets = CoinMarkets(
    stats: sampleMarketStats,
    coins: [sampleCoin]
)
