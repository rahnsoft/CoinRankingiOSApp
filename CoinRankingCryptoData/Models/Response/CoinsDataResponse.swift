//
//  Welcome.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//

import CoinRankingCryptoDomain
import Foundation

// MARK: - CoinsDataResponse

struct CoinsDataResponse: BaseDataModel, Codable {
    let stats: StatsResponse?
    let coins: [CoinsResponse]?
    
    enum CodingKeys: String, CodingKey {
        case stats
        case coins
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stats = try container.decodeIfPresent(StatsResponse.self, forKey: .stats)
        self.coins = try container.decodeIfPresent([CoinsResponse].self, forKey: .coins)
    }
    
    func toDomainModel() -> CoinMarkets {
        return CoinMarkets(
            stats: (stats ?? StatsResponse()).toDomainModel(),
            coins: coins?.compactMap { $0.toDomainModel() } ?? []
        )
    }
}

// MARK: - CoinsResponse

struct CoinsResponse: Codable {
    let uuid, symbol, name, description: String?
    let color: String?
    let iconURL, websiteUrl: String?
    let marketCap, price: String?
    let listedAt, tier: Int?
    let change: String?
    let rank: Int?
    let sparkline: [String?]
    let lowVolume: Bool?
    let coinrankingURL: String?
    let the24HVolume, btcPrice: String?
    let contractAddresses: [String]?
    let isWrappedTrustless: Bool?
    let wrappedTo: String?
    let supply: SupplyResponse?
    let allTimeHigh: AllTimeHighResponse?
    
    init(uuid: String? = nil,
         symbol: String? = nil,
         name: String? = nil,
         description: String? = nil,
         color: String? = nil,
         iconURL: String? = nil,
         websiteUrl: String? = nil,
         marketCap: String? = nil,
         price: String? = nil,
         listedAt: Int? = nil,
         tier: Int? = nil,
         change: String? = nil,
         rank: Int? = nil,
         sparkline: [String?] = [],
         lowVolume: Bool? = nil,
         coinrankingURL: String? = nil,
         the24HVolume: String? = nil,
         btcPrice: String? = nil,
         contractAddresses: [String]? = nil,
         isWrappedTrustless: Bool? = nil,
         wrappedTo: String? = nil,
         supply: SupplyResponse? = nil,
         allTimeHigh: AllTimeHighResponse? = nil)
    {
        self.uuid = uuid
        self.symbol = symbol
        self.name = name
        self.description = description
        self.color = color
        self.iconURL = iconURL
        self.websiteUrl = websiteUrl
        self.marketCap = marketCap
        self.price = price
        self.listedAt = listedAt
        self.tier = tier
        self.change = change
        self.rank = rank
        self.sparkline = sparkline
        self.lowVolume = lowVolume
        self.coinrankingURL = coinrankingURL
        self.the24HVolume = the24HVolume
        self.btcPrice = btcPrice
        self.contractAddresses = contractAddresses
        self.isWrappedTrustless = isWrappedTrustless
        self.wrappedTo = wrappedTo
        self.supply = supply
        self.allTimeHigh = allTimeHigh
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case symbol
        case name
        case description
        case websiteUrl
        case color
        case iconURL = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingURL = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice, contractAddresses, isWrappedTrustless, wrappedTo
        case supply
        case allTimeHigh
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        self.iconURL = try container.decodeIfPresent(String.self, forKey: .iconURL)
        self.websiteUrl = try container.decodeIfPresent(String.self, forKey: .websiteUrl)
        self.marketCap = try container.decodeIfPresent(String.self, forKey: .marketCap)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.listedAt = try container.decodeIfPresent(Int.self, forKey: .listedAt)
        self.tier = try container.decodeIfPresent(Int.self, forKey: .tier)
        self.change = try container.decodeIfPresent(String.self, forKey: .change)
        self.rank = try container.decodeIfPresent(Int.self, forKey: .rank)
        self.sparkline = try container.decode([String?].self, forKey: .sparkline)
        self.lowVolume = try container.decodeIfPresent(Bool.self, forKey: .lowVolume)
        self.coinrankingURL = try container.decodeIfPresent(String.self, forKey: .coinrankingURL)
        self.the24HVolume = try container.decodeIfPresent(String.self, forKey: .the24HVolume)
        self.btcPrice = try container.decodeIfPresent(String.self, forKey: .btcPrice)
        self.contractAddresses = try container.decodeIfPresent([String].self, forKey: .contractAddresses)
        self.isWrappedTrustless = try container.decodeIfPresent(Bool.self, forKey: .isWrappedTrustless)
        self.wrappedTo = try container.decodeIfPresent(String.self, forKey: .wrappedTo)
        self.supply = try container.decodeIfPresent(SupplyResponse.self, forKey: .supply)
        self.allTimeHigh = try container.decodeIfPresent(AllTimeHighResponse.self, forKey: .allTimeHigh)
    }
    
    func toDomainModel() -> Coin {
        return Coin(
            id: uuid ?? "",
            symbol: symbol ?? "",
            name: name ?? "",
            description: description ?? "",
            colorHex: color,
            iconURL: URL(string: iconURL ?? ""),
            websiteURL: URL(string: websiteUrl ?? ""),
            marketCap: Double(marketCap ?? ""),
            price: Double(price ?? ""),
            listedAt: listedAt.flatMap { Date(timeIntervalSince1970: TimeInterval($0)) },
            tier: tier,
            change24h: Double(change ?? ""),
            rank: rank,
            sparkline: sparkline.compactMap { Double($0 ?? "") },
            lowVolume: lowVolume ?? false,
            detailURL: URL(string: coinrankingURL ?? ""),
            volume24h: Double(the24HVolume ?? ""),
            btcPrice: Double(btcPrice ?? ""),
            contractAddresses: contractAddresses ?? [],
            isWrappedTrustless: isWrappedTrustless ?? false,
            wrappedTo: wrappedTo,
            supply: (supply ?? SupplyResponse()).toDomainModel(),
            allTimeHighPrice: allTimeHigh?.price ?? "",
        )
    }
}

// MARK: - SupplyResponse

struct SupplyResponse: BaseDataModel, Codable {
    let confirmed: Bool?
    let supplyAt: Int?
    let circulating, total, max: String?
    
    init(confirmed: Bool? = nil,
         supplyAt: Int? = nil,
         circulating: String? = nil,
         total: String? = nil,
         max: String? = nil)
    {
        self.confirmed = confirmed
        self.supplyAt = supplyAt
        self.circulating = circulating
        self.total = total
        self.max = max
    }
    
    enum CodingKeys: String, CodingKey {
        case confirmed
        case supplyAt
        case circulating
        case total
        case max
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.confirmed = try container.decodeIfPresent(Bool.self, forKey: .confirmed)
        self.supplyAt = try container.decodeIfPresent(Int.self, forKey: .supplyAt)
        self.circulating = try container.decodeIfPresent(String.self, forKey: .circulating)
        self.total = try container.decodeIfPresent(String.self, forKey: .total)
        self.max = try container.decodeIfPresent(String.self, forKey: .max)
    }
    
    func toDomainModel() -> Supply {
        return Supply(
            confirmed: confirmed ?? false,
            supplyAt: supplyAt ?? 0,
            circulating: circulating ?? "",
            total: total ?? "",
            max: max ?? ""
        )
    }
}

// MARK: - AllTimeHighResponse

struct AllTimeHighResponse: Codable {
    let price: String?
    let timestamp: Int?
    
    init(price: String? = nil, timestamp: Int? = nil) {
        self.price = price
        self.timestamp = timestamp
    }
    
    enum CodingKeys: String, CodingKey {
        case price
        case timestamp
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.timestamp = try container.decodeIfPresent(Int.self, forKey: .timestamp)
    }
}

// MARK: - StatsResponse

struct StatsResponse: Codable {
    let total, totalCoins, totalMarkets, totalExchanges: Int?
    let totalMarketCap, total24HVolume: String?

    init(total: Int? = nil,
         totalCoins: Int? = nil,
         totalMarkets: Int? = nil,
         totalExchanges: Int? = nil,
         totalMarketCap: String? = nil,
         total24HVolume: String? = nil)
    {
        self.total = total
        self.totalCoins = totalCoins
        self.totalMarkets = totalMarkets
        self.totalExchanges = totalExchanges
        self.totalMarketCap = totalMarketCap
        self.total24HVolume = total24HVolume
    }
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalCoins
        case totalMarkets
        case totalExchanges
        case totalMarketCap
        case total24HVolume = "total24hVolume"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.totalCoins = try container.decodeIfPresent(Int.self, forKey: .totalCoins)
        self.totalMarkets = try container.decodeIfPresent(Int.self, forKey: .totalMarkets)
        self.totalExchanges = try container.decodeIfPresent(Int.self, forKey: .totalExchanges)
        self.totalMarketCap = try container.decodeIfPresent(String.self, forKey: .totalMarketCap)
        self.total24HVolume = try container.decodeIfPresent(String.self, forKey: .total24HVolume)
    }
    
    func toDomainModel() -> MarketStats {
        return MarketStats(
            total: total ?? 0,
            totalCoins: totalCoins ?? 0,
            totalMarkets: totalMarkets ?? 0,
            totalExchanges: totalExchanges ?? 0,
            totalMarketCap: Double(totalMarketCap ?? "") ?? 0,
            totalVolume24h: Double(total24HVolume ?? "") ?? 0
        )
    }
}
