//
//  TabBarViewController.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 24/05/2024.
//

import RxSwift
import UIKit

class TabViewController: UITabBarController {
    private var viewModel: TabBarViewModel
    
    init(_ viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemBackground

        appearance.stackedLayoutAppearance.selected.iconColor = .label
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = .systemGray2
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.systemGray2
        ]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        tabBar.isTranslucent = false
    }
}
