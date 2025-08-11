//
//  AppDelegate.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import FirebaseCore
import IQKeyboardManagerSwift
import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import Swinject
import UIKit
import UserNotifications
import FirebaseMessaging

// MARK: - AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DefaultAppearance().configure()
        registerDependencies()
        initializeLibraries()
        return true
    }

    private func initializeLibraries() {
//        configureFirebase()
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        IQKeyboardManager.shared.toolbarConfiguration.tintColor = .systemOrange
        IQKeyboardManager.shared.keyboardDistance = 40
    }

    private func configureFirebase() {
        FirebaseApp.configure()
        setUpPushNotifications()
    }

    private func setUpPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) {
            granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError _: Error) {}

    func application(_: UIApplication,
                     didReceiveRemoteNotification _: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        completionHandler(.newData)
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

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {}

    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                
            } else {
                sPrint("Permission denied: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func registerForPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) {
            granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
}
