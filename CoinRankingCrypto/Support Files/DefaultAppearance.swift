//
//  DefaultAppearance.swift
//  CoinBaseCrypto
//
//  Created by Nick on 05/08/2025.
//


import Foundation
import UIKit

class DefaultAppearance {
    func configure() {
        configureTabBarDefaultAppearance()
        configureNavigationBarDefaultAppearance()
    }

    func configureTabBarDefaultAppearance() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.SBFont.medium.font(13)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.SBFont.semiBold.font(13)], for: .selected)
    }

    private func configureNavigationBarDefaultAppearance() {
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().barTintColor = .label
        UINavigationBar.appearance().barStyle = .default
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .label
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label,
                                          .font: UIFont.SBFont.semiBold.font(18)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label,
                                               .font: UIFont.SBFont.extraBold.font(32)]
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.label,
                                                       .font: UIFont.SBFont.semiBold.font(18)]
        buttonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label,
                                                            .font: UIFont.SBFont.semiBold.font(18)]
        buttonAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.systemGray2,
                                                         .font: UIFont.SBFont.semiBold.font(18)]
        appearance.buttonAppearance = buttonAppearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
