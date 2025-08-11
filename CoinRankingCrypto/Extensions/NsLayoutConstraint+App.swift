//
//  NsLayoutConstraint+App.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import UIKit

extension NSLayoutConstraint {
    func updateConstantWithAnimation(_ constant: CGFloat, _ view: UIView) {
        self.constant = constant
        UIView.animate(withDuration: 0.3) {
            view.layoutIfNeeded()
        }
    }
}
