//
//  CoinRankingCryptoDependencyInjection.swift
//  CoinRankingCryptoDependencyInjection
//
//  Created by Nick on 06/08/2025.
//

import Swinject

public class DependencyInjection {
    public static let shared = DependencyInjection()
    private var container: Container?

    private init() {}

    public func setContainer(_ container: Container) {
        self.container = container
    }

    public func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container?.resolve(serviceType) else {
            fatalError("Missing dependencies")
        }
        return service
    }
}
