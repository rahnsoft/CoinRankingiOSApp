//
//  TabBarBackgroundView.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 24/05/2024.
//

import UIKit

class TabBarBackgroundView: UIView {
    // MARK: Constants

    private let tabHeight: CGFloat = 103
    private let startY: CGFloat = 8
    private let cornerRadius: CGFloat = 24
    private let shadowLayer = CAShapeLayer()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y - startY, width: frame.size.width, height: tabHeight))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func configureView(selectedTabCenterX _: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )

        // Apply shape mask
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = path.cgPath
        backgroundColor = UIColor.label
        layer.mask = shapeLayer

        // Shadow
        shadowLayer.path = path.cgPath
        shadowLayer.frame = frame
        shadowLayer.shadowColor = UIColor.label.cgColor
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
        shadowLayer.shadowRadius = 4
        superview?.layer.insertSublayer(shadowLayer, below: layer)
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        shadowLayer.removeFromSuperlayer()
    }
}
