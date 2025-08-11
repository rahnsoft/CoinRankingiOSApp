//
//  DetailsUITableViewCell 2.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//


import CoinRankingCryptoDomain
import SnapKit
import UIKit

class DescriptionTableViewCell: UITableViewCell {
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.semiBold.font(28)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.medium.font(12)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.regular.font(16)
        label.textColor = .systemGray2
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(_ title: String, _ subtitle: String, _ description: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descriptionLabel.text = description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        descriptionLabel.text = nil
    }
}
