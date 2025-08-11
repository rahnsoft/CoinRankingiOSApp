//
//  HomeRepositoryTests.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//

import XCTest
import RxSwift
import RxBlocking

@testable import CoinRankingCryptoData
@testable import CoinRankingCryptoDomain

final class HomeRepositoryTests: XCTestCase {
    var repository: HomeRepository!
    var mockRemoteDataSource: MockHomeRemoteDataSource!
    var mockLocalDataSource: MockLocalDefaultsDataSource!

    override func setUp() {
        super.setUp()
        mockRemoteDataSource = MockHomeRemoteDataSource()
        mockLocalDataSource = MockLocalDefaultsDataSource()
        repository = HomeRepository(localDefaultsDataSource: mockLocalDataSource,
                                    homeRemoteDataSource: mockRemoteDataSource)
    }

    override func tearDown() {
        repository = nil
        mockRemoteDataSource = nil
        mockLocalDataSource = nil
        super.tearDown()
    }

    func testGetCoinsList_callsRemoteDataSourceAndReturnsData() throws {
        mockRemoteDataSource.stubbedCoinsMarkets = sampleCoinMarkets

        let result = try repository.getCoinsList(10, 0, "marketCap", "desc")
            .toBlocking()
            .first()

        XCTAssertTrue(mockRemoteDataSource.getCoinsListCalled)
        XCTAssertEqual(result?.stats.total, sampleCoinMarkets.stats.total)
        XCTAssertEqual(result?.coins.first?.id, sampleCoinMarkets.coins.first?.id)
    }

    func testGetCoinsUUIDList_callsRemoteDataSourceAndReturnsData() throws {
        mockRemoteDataSource.stubbedCoinsMarkets = sampleCoinMarkets

        let result = try repository.getCoinsUUIDList(["bitcoin"], 10, 0, "marketCap", "desc")
            .toBlocking()
            .first()

        XCTAssertTrue(mockRemoteDataSource.getCoinsUUIDListCalled)
        XCTAssertEqual(result?.stats.total, sampleCoinMarkets.stats.total)
        XCTAssertEqual(result?.coins.first?.id, sampleCoinMarkets.coins.first?.id)
    }

    func testGetCoinDetails_callsRemoteDataSourceAndReturnsData() throws {
        mockRemoteDataSource.stubbedCoin = sampleCoin

        let result = try repository.getCoinDetails("bitcoin", "24h")
            .toBlocking()
            .first()

        XCTAssertTrue(mockRemoteDataSource.getCoinDetailsCalled)
        XCTAssertEqual(result?.id, sampleCoin.id)
        XCTAssertEqual(result?.name, sampleCoin.name)
    }

    func testSaveCoinsUUIDs_savesToLocalDataSource() {
        let uuids = ["bitcoin", "ethereum"]

        repository.saveCoinsUUids(uuids)

        XCTAssertEqual(mockLocalDataSource.savedUUIDs, uuids)
    }

    func testGetCoinsUUIDs_returnsFromLocalDataSource() {
        let uuids = ["bitcoin", "ethereum"]
        mockLocalDataSource.returnedUUIDs = uuids

        let result = repository.getCoinsUUids()

        XCTAssertEqual(result, uuids)
    }
}
