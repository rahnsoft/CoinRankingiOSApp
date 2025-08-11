//
//  UILabel+App.swift
//  CoinRankingCrypto
//
//  Created by Nick on 05/08/2025.
//

import Foundation
import UIKit

extension UILabel {
    func addTrailing(image: UIImage?, imageSize: CGSize, imageSpacing: CGFloat = 20) {
        guard let image = image else {
            // Handle the case where the image is nil
            return
        }

        // Resize the image to the desired size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: imageSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Create an NSTextAttachment with the resized image
        let attachment = NSTextAttachment()
        attachment.image = resizedImage

        // Adjust the bounds of the attachment to align with the text
        let font = self.font ?? UIFont.systemFont(ofSize: 14) // Default to system font if none is set
        let offsetY = (font.capHeight - imageSize.height) / 2 // Align vertically with the text
        attachment.bounds = CGRect(x: imageSpacing, y: offsetY, width: imageSize.width, height: imageSize.height)

        // Create the attributed string with the attachment
        let attachmentString = NSAttributedString(attachment: attachment)

        // Create the NSMutableAttributedString
        let string = NSMutableAttributedString(string: text ?? "", attributes: [:])
        string.append(attachmentString)

        // Set the new attributed text
        attributedText = string
    }
}
