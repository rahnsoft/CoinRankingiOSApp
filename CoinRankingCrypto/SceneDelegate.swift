//
//  SceneDelegate.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//
import IQKeyboardManagerSwift
import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import Swinject
import UIKit

var currentScene: UIScene?

// MARK: - SceneDelegate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var isLockPresented = false

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        DefaultAppearance().configure()
        guard let _ = (scene as? UIWindowScene) else { return }
        if let windowScene = scene as? UIWindowScene {
            currentScene = scene
            window = UIWindow(windowScene: windowScene)
            window?.backgroundColor = .white
        }
        guard NSClassFromString("XCTest") == nil else {
            registerTestDependencies()
            return
        }
        registerDependencies()
        SplashCoordinator(getWindow()).start()
    }

    func getWindow() -> UIWindow? {
        return window
    }

    private func registerDependencies() {
        let container = Container()
        container.registerDataDependencies()
        container.registerDomainDependencies()
        container.registerAppDependencies()
        DependencyInjection.shared.setContainer(container)
    }

    private func registerTestDependencies() {
        let container = Container()
        container.registerDataTestDependencies()
        container.registerDomainDependencies()
        container.registerAppDependencies()
        DependencyInjection.shared.setContainer(container)
    }
}
