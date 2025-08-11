//
//  SplashViewController.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import RxCocoa
import RxSwift
import SwiftUI

struct SplashView: View {
    let viewModel: SplashViewModel

    var body: some View {
        ZStack {
            Color(.systemBackground)
            VStack(spacing: -18) {
                Image("Splash_dot_icon")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(.systemOrange))
                    .offset(x: -26)

                Text(Strings.commonTitle.localized())
                    .font(.SBFont.semiBold.font(48))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }.offset(y: -32)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            viewModel.checkAuth()
        }
    }
}
