//
//  HomeViewController.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wambui on 11/25/24.
//
import CoinRankingCryptoDomain
import DGCharts
import Foundation
import RxSwift
import UIKit

// MARK: - HomeViewController

class HomeViewController: BaseViewController, UISearchResultsUpdating {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray5
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadMoreFooter: LoadMoreFooterView = {
        let footer = LoadMoreFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        footer.stopAnimating()
        return footer
    }()
    
    var viewModel: HomeViewModel
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        searchController.searchResultsUpdater = self
        configureView()
        configureObservables()
        viewModel.getCoinsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureView() {
        title = Strings.commonMarkets.localized()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        view.addSubview(sortButton)
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }

        tableView.snp.remakeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(HomeUITableViewCell.self, forCellReuseIdentifier: HomeUITableViewCell.identifier)
        loadMoreFooter.stopAnimating()
        tableView.tableFooterView = nil
    }
    
    func configureObservables() {
        sortButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.showSortOptions()
            })
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.getCoinsList(true)
            })
            .disposed(by: disposeBag)
        
        viewModel.coinListDataSource
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: HomeUITableViewCell.identifier,
                                         cellType: HomeUITableViewCell.self))
        { _, coin, cell in
            cell.configureCell(coin)
        }
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let coinId = self.viewModel.coinListDataSource.value[indexPath.row].id
            self.viewModel.getCoinDetails(coinId)
                
        }).disposed(by: disposeBag)
        
        viewModel.loadingRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }

                if self.refreshControl.isRefreshing {
                    if !isLoading {
                        self.refreshControl.endRefreshing()
                    }
                } else {
                    if isLoading {
                        if self.viewModel.hasMoreData {
                            self.loadMoreFooter.startAnimating()
                            self.tableView.tableFooterView = self.loadMoreFooter
                        } else {
                            self.tableView.tableFooterView = nil
                        }
                    } else {
                        self.loadMoreFooter.stopAnimating()
                        if !self.viewModel.hasMoreData {
                            self.tableView.tableFooterView = nil
                        } else {
                            self.tableView.tableFooterView = self.loadMoreFooter
                        }
                        self.tableView.reloadData()
                    }
                    self.updateLoading(isLoading, self.view)
                }
            })
            .disposed(by: disposeBag)

        viewModel.successRelay.subscribe(onNext: { [weak self] message in
            guard let self = self else { return }
            self.showSuccessMessage(message)
        }).disposed(by: disposeBag)
    }
    
    private func showSortOptions() {
        let alert = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)

        let priceAction = UIAlertAction(title: "Highest Price", style: .default) { [weak self] _ in
            self?.applySorting(.price)
        }
        priceAction.setValue(UIColor.label, forKey: "titleTextColor")

        let performanceAction = UIAlertAction(title: "Best 24-hour Performance", style: .default) { [weak self] _ in
            self?.applySorting(.performance)
        }
        performanceAction.setValue(UIColor.label, forKey: "titleTextColor")

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAction.setValue(UIColor.systemGray, forKey: "titleTextColor")

        alert.addAction(priceAction)
        alert.addAction(performanceAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    
    private func applySorting(_ option: SortOption) {
        currentSortOption = option

        switch option {
        case .price:
            sortButton.setTitle("Sort: Price ▼", for: .normal)
        case .performance:
            sortButton.setTitle("Sort: 24h Performance ▼", for: .normal)
        }
        
        let sorted = sortedCoins(from: viewModel.coinListDataSource.value, by: option)
        viewModel.coinListDataSource.accept(sorted)
    }

    override func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.lowercased(), !query.isEmpty else {
            searchResultsController.updateResults([])
            return
        }
                    
        let filtered = viewModel.coinsList.value.filter { coin in
            coin.name.lowercased().contains(query) || coin.symbol.lowercased().contains(query)
        }
        searchResultsController.updateResults(filtered)
    }
}

// MARK: UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight * 1.5 {
            if !viewModel.isLoadingMore && viewModel.hasMoreData {
                viewModel.getCoinsList()
            }
        }
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = viewModel.coinListDataSource.value[indexPath.row]
        
        let favoriteAction = UIContextualAction(style: .normal, title: Strings.favourites.localized().capitalized) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            
            self.toggleFavoriteCoin(coin.id)
            
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = .systemOrange
        favoriteAction.image = UIImage(systemName: "star.fill")
        
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    func toggleFavoriteCoin(_ coinId: String) {
        var favorites = viewModel.getCoinsUUIDs()
        if let index = favorites.firstIndex(of: coinId) {
            favorites.remove(at: index)
            favorites.append(coinId)
        } else {
            favorites.append(coinId)
        }
        viewModel.saveCoinsUUIDs(favorites)
    }
}
