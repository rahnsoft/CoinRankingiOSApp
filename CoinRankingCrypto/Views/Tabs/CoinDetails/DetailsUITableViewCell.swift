//
//  DetailsUITableViewCell.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//

import CoinRankingCryptoDomain
import SnapKit
import UIKit

class DetailsUITableViewCell: UITableViewCell {
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.regular.font(16)
        label.numberOfLines = 0
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.medium.font(16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
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
        selectionStyle = .none
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(subtitleLabel)

        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2)
        }
    }

    func configure(_ title: String, _ subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
}
