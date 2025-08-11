//
//  GetStartedUICollectionViewCell.swift
//  CoinRankingCrypto
//
//  Created by Nick on 08/08/2025.
//

import CoinRankingCryptoDomain
import SwiftUI
import UIKit

// MARK: - GetStartedView

struct GetStartedView: View {
    let viewModel: GetStartedViewModel
    @State private var currentIndex = 0

    private let pages: [OnboardingPage] = [
        .init(imageName: "Get_started_1", title: Strings.getStartedOneTitle.localized(), description: Strings.getStartedOneSubTitle.localized()),
        .init(imageName: "Get_started_2", title: Strings.getStartedTwoTitle.localized(), description: Strings.getStartedTwoSubTitle.localized()),
        .init(imageName: "Get_started_3", title: Strings.getStartedThreeTitle.localized(), description: Strings.getStartedThreeSubTitle.localized())
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                ForEach(0 ..< pages.count, id: \.self) { index in
                    Rectangle()
                        .fill(index <= currentIndex ? Color(.label) : Color(.systemGray4))
                        .frame(
                            width: (UIScreen.main.bounds.width - 32 - 16 * CGFloat(pages.count - 1)) / CGFloat(pages.count),
                            height: 2
                        )
                        .animation(.easeInOut, value: currentIndex)
                }
            }
            .padding(.horizontal, 16)

            TabView(selection: $currentIndex) {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingPageView(
                        page: pages[index],
                        isLast: index == pages.count - 1
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            VStack(spacing: 32) {
                SBButtonRepresentable(
                    title: currentIndex < pages.count - 1 ? Strings.commonContinue.localized() : Strings.getStarted.localized(),
                    cornerRadius: 12,
                    backgroundColor: .systemOrange,
                    titleColor: .label,
                    status: .enabled
                ) {
                    if currentIndex < pages.count - 1 {
                        currentIndex += 1
                    } else {
                         viewModel.goToLogin()
                    }
                }
                .frame(height: 48)
                .padding(.horizontal, 16)

                if currentIndex < 2 {
                    Button(action: {
                        currentIndex = pages.count - 1
                    }) {
                        Text(Strings.skip.localized())
                            .font(.SBFont.semiBold.font(16))
                            .foregroundColor(Color(.label))
                    }
                }
            }
            .padding(.bottom, 48)
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(.keyboard)
    }
}


// MARK: - OnboardingPageView

struct OnboardingPageView: View {
    let page: OnboardingPage
    let isLast: Bool

    var body: some View {
        VStack(spacing: 32) {
            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(
                    height: isLast ? UIScreen.main.bounds.height / 2.5 : nil
                )
                .frame(width: 260, alignment: .center)
                .padding(.top, 40)
                .animation(.easeInOut(duration: 0.3), value: isLast)

            VStack(alignment: .leading, spacing: 24) {
                Text(page.title)
                    .font(.SBFont.semiBold.font(28))
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.leading)

                Text(makeDescriptionAttributedString(from: page.description))
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 16)
            Spacer()
        }
    }

    private func makeDescriptionAttributedString(from text: String) -> AttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 18
        paragraphStyle.maximumLineHeight = 18

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.SBFont.medium.font(16),
            .foregroundColor: UIColor.systemGray2,
            .paragraphStyle: paragraphStyle
        ]

        let attributed = NSAttributedString(string: text, attributes: attributes)
        return AttributedString(attributed)
    }
}
