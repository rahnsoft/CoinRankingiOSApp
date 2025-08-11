import SwiftUI
import UIKit

// MARK: - UIFont.SBFont

extension UIFont {
    enum SBFont: String {
        case regular = "Satoshi-Regular"
        case medium = "Satoshi-Medium"
        case semiBold = "Satoshi-Bold"
        case extraBold = "Satoshi-Black"

        func font(_ size: CGFloat) -> UIFont {
            guard let font = UIFont(name: self.rawValue, size: size) else {
                assertionFailure("⚠️ Failed to load font: \(rawValue)")
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
    }
}

// MARK: - Font.SBFont

extension Font {
    enum SBFont: String {
        case regular = "Satoshi-Regular"
        case medium = "Satoshi-Medium"
        case semiBold = "Satoshi-Bold"
        case extraBold = "Satoshi-Black"

        func font(_ size: CGFloat) -> Font {
            Font.custom(self.rawValue, size: size)
        }
    }
}
