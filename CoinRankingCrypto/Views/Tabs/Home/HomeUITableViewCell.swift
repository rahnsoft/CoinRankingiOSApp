//
//  HomeUITableViewCell.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//

import UIKit
import CoinRankingCryptoDomain
import Kingfisher

class HomeUITableViewCell: UITableViewCell {
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")
        imageView.image = image
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var mainView: UIView = {
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
        label.font = .SBFont.regular.font(14)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.semiBold.font(14)
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .right
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    
    func setupCell() {
        selectionStyle = .none
        contentView.addSubview(mainView)
        mainView.addSubview(iconImageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(subtitleLabel)
        mainView.addSubview(priceLabel)
        mainView.addSubview(perfomanceLabel)
        mainView.addSubview(chevronImageView)

        mainView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
        }
        
        perfomanceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.trailing.equalTo(priceLabel.snp.trailing)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        chevronImageView.snp.makeConstraints { make in
             make.centerY.equalToSuperview()
             make.trailing.equalToSuperview().offset(-8)
             make.width.equalTo(12)
             make.height.equalTo(20)
         }
        
    }
    
    func configureCell(_ model: UIModel) {
        if let url = model.iconURL {
            iconImageView.setImage(url, placeholder: nil)
        }
        
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        priceLabel.text = model.price
        perfomanceLabel.text =  "\(model.performance)% (24h)"
        perfomanceLabel.textColor = model.performance >= 0 ? .systemGreen : .systemRed
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        priceLabel.text = nil
        perfomanceLabel.text = nil
        perfomanceLabel.textColor = .label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeUITableViewCell {
    struct UIModel {
        let id: String
        let iconURL: URL?
        let title: String
        let subtitle: String
        let price: String
        let performance: Double
    }
}
