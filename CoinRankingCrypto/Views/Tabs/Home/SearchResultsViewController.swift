//
//  SearchResultsViewController.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//
import CoinRankingCryptoDomain
import UIKit

// MARK: - SearchResultsViewController

class SearchResultsViewController: UITableViewController {
    var filteredCoins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HomeUITableViewCell.self, forCellReuseIdentifier: HomeUITableViewCell.identifier)
    }

    func updateResults(_ coins: [Coin]) {
        filteredCoins = coins
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension SearchResultsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCoins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeUITableViewCell.identifier, for: indexPath) as? HomeUITableViewCell else {
            return UITableViewCell()
        }
        let coin = filteredCoins[indexPath.row]
        let model = HomeUITableViewCell.UIModel(
            id: coin.id,
            iconURL: coin.iconURL,
            title: coin.symbol.uppercased(),
            subtitle: coin.name,
            price: coin.price?.formattedNumber() ?? "-",
            performance: coin.change24h ?? 0.0,
        )

        cell.configureCell(model)
        return cell
    }

    // Implement didSelectRow if needed
}
