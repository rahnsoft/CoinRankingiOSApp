//
//  LoadMoreFooterView.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//
import UIKit

class LoadMoreFooterView: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Loading more..."
        label.textColor = .label
        label.font = .systemFont(ofSize: 14)

        addSubview(activityIndicator)
        addSubview(label)

        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            label.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimating() {
        activityIndicator.startAnimating()
        isHidden = false
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}
