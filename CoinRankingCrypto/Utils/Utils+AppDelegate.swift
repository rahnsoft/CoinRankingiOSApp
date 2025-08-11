//
//  Uitls+AppDelegate.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import UIKit

var sceneDelegate: SceneDelegate? {
    for scene in UIApplication.shared.connectedScenes {
        if scene == currentScene,
           let delegate = scene.delegate as? SceneDelegate
        {
            return delegate
        }
    }
    return nil
}

var appWindow: UIWindow? {
    if let window = sceneDelegate?.window {
        return window
    }
    return sceneDelegate?.window
}

var isKeyWindow: Bool? {
    return appWindow?.isKeyWindow
}
