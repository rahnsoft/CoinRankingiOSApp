//
//  UIButton+App.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import Foundation
import UIKit

extension UIButton {
    private enum AssociatedKeys {
        static var hitTestEdgeInsets = "hitTestEdgeInsets"
    }

    var hitTestEdgeInsets: UIEdgeInsets {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.hitTestEdgeInsets) as? UIEdgeInsets else {
                return .zero
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hitTestEdgeInsets, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let hitTestEdgeInsets = objc_getAssociatedObject(self, &AssociatedKeys.hitTestEdgeInsets) as? UIEdgeInsets else {
            return super.point(inside: point, with: event)
        }

        if hitTestEdgeInsets == .zero || !isEnabled || isHidden {
            return super.point(inside: point, with: event)
        }

        let hitFrame = bounds.inset(by: hitTestEdgeInsets)
        return hitFrame.contains(point)
    }
}

extension UIButton {
    private var imageView: UIImageView? {
        for subview in subviews {
            if let iv = subview as? UIImageView {
                return iv
            }
        }
        return nil
    }

    @available(iOS 17.0, *)
    func addSymbolEffect(_ effect: some IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.addSymbolEffect(effect, options: options, animated: animated, completion: completion)
    }

    @available(iOS 17.0, *)
    func addSymbolEffect(_ effect: some DiscreteSymbolEffect & IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.addSymbolEffect(effect, options: options, animated: animated, completion: completion)
    }

    @available(iOS 17.0, *)
    func addSymbolEffect(_ effect: some DiscreteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.addSymbolEffect(effect, options: options, animated: animated, completion: completion)
    }

    @available(iOS 17.0, *)
    func removeSymbolEffect(ofType effect: some IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.removeSymbolEffect(ofType: effect, options: options, animated: animated, completion: completion)
    }

    @available(iOS 17.0, *)
    func removeSymbolEffect(ofType effect: some DiscreteSymbolEffect & IndefiniteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.removeSymbolEffect(ofType: effect, options: options, animated: animated, completion: completion)
    }

    @available(iOS 17.0, *)
    func removeSymbolEffect(ofType effect: some DiscreteSymbolEffect & SymbolEffect, options: SymbolEffectOptions = .default, animated: Bool = true, completion: UISymbolEffectCompletion? = nil) {
        imageView?.removeSymbolEffect(ofType: effect, options: options, animated: animated, completion: completion)
    }

    @available(iOS 17.0, *)
    func removeAllSymbolEffects(options: SymbolEffectOptions = .default, animated: Bool = true) {
        imageView?.removeAllSymbolEffects(options: options, animated: animated)
    }
}
