//
//  SectionModel+App.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import Foundation
import RxDataSources

struct SectionModel {
    var header: String
    var items: [Any]
    var itemsCount: Int {
        return items.count
    }
}

extension SectionModel: SectionModelType {
    init(original: SectionModel, items: [Any]) {
        self = original
        self.items = items
    }
}
