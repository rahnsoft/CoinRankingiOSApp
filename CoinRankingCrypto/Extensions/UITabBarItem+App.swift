//
//  UITabBarItem+App.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import Foundation
import UIKit

extension UITabBarItem {
    convenience init(_ title: String, _ imageName: String, _ selectedImageName: String, _ isCentral: Bool = false) {
        self.init(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        if isCentral {
            imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }
    }
}
