//
//  LoadingView.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 07/05/2024.
//

import Foundation

import UIKit
import Lottie

class LoadingView: UIView {
    private var animationView: LottieAnimationView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    private func configureView() {
        backgroundColor = .white
        let animation = LottieAnimation.named("LoaderAnimation")
        animationView = LottieAnimationView(animation: animation)

        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.animationSpeed = 2

        addSubview(animationView)

        animationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
        }
        animationView.play()
    }
}
