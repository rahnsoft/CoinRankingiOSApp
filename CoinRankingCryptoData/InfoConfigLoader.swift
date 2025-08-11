//
//  InfoConfigLoader.swift
//  CoinRankingCrypto
//
//  Created by Nick on 10/08/2025.
//


import Foundation

public enum InfoConfigLoader {
    public static func loadPlist(named name: String) -> [String: Any]? {
        let bundle = Bundle(for: InfoConfigLoaderMarker.self)

        guard let url = bundle.url(forResource: name, withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(
                  from: data,
                  options: [],
                  format: nil
              ) as? [String: Any]
        else {
            sPrint("⚠️ Failed to load plist named: \(name)")
            return nil
        }

        return plist
    }

    public static func loadEnvironmentConfigPlist() -> [String: Any]? {
        return loadPlist(named: "infoConfig")
    }
}

private final class InfoConfigLoaderMarker {}
