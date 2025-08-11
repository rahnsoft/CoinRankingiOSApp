//
//  CoinDetailsViewController.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wambui on 11/25/24.
//
import CoinRankingCryptoDomain
import DGCharts
import Foundation
import RxSwift
import UIKit

// MARK: - CoinDetailsViewController

class CoinDetailsViewController: BaseViewController {
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.semiBold.font(14)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.medium.font(28)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.medium.font(14)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var perfomanceLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.regular.font(14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lineChartView: SparklineChartView = {
        let chartView = SparklineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var viewModel: HomeViewModel!
    var coinSymbol = ""

    init(_ viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureView() {
        title = viewModel.selectedCoin.value?.name ?? "Coin Details"
        view.addSubview(topView)
        topView.addSubview(iconImageView)
        topView.addSubview(titleLabel)
        topView.addSubview(subtitleLabel)
        topView.addSubview(priceLabel)
        topView.addSubview(lineChartView)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(iconImageView.snp.leading).offset(-8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalTo(iconImageView.snp.leading).offset(-8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(iconImageView.snp.leading).offset(-8)
        }
            
        lineChartView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsUITableViewCell.self, forCellReuseIdentifier: DetailsUITableViewCell.identifier)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
    }
    
    func configureObservables() {
        viewModel.selectedCoin.subscribe(onNext: { [weak self] coin in
            guard let self = self else { return }
            if let coin = coin {
                self.setupUI(coin)
            }
        }).disposed(by: disposeBag)
    }
    
    func setupUI(_ coin: Coin) {
        if let url = coin.iconURL {
            iconImageView.setImage(url, placeholder: nil)
        }
        titleLabel.text = coin.name + " (\(coin.symbol.uppercased()))"
        subtitleLabel.text = coin.price?.formattedNumber()
        let isNegativeChange = coin.change24h ?? 0 < 0
        priceLabel.text = "\(coin.change24h ?? 0)% (24h)"
        priceLabel.textColor = isNegativeChange ? .systemRed : .systemGreen
        lineChartView.setSparklineData(coin.sparkline, symbol: coin.symbol.uppercased())
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension CoinDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.dataDetails.value?.count ?? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsUITableViewCell.identifier, for: indexPath) as? DetailsUITableViewCell ?? DetailsUITableViewCell()
            if let detail = viewModel.dataDetails.value?[indexPath.row] {
                cell.configure(detail.0, detail.1)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as? DescriptionTableViewCell ?? DescriptionTableViewCell()
            if let detail = viewModel.selectedCoin.value {
                cell.configure(detail.name, "Symbol \(detail.symbol)", detail.description + " \(detail.websiteURL?.absoluteString ?? "")")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Section Headers
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 32
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .SBFont.regular.font(12)
        label.textAlignment = .left
        
        switch section {
        case 0:
            label.text = "Data"
        case 1:
            label.text = "Quick overview"
        default:
            label.text = ""
        }
        
        headerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }
}
