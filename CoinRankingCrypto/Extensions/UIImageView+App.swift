
import Kingfisher
import KingfisherSVG
import UIKit

extension UIImageView {
    func setImage(fromBase64 base64String: String, placeholder: UIImage? = nil) -> Bool {
        guard let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters),
              let image = UIImage(data: imageData)
        else {
            self.image = placeholder
            return false
        }

        self.image = image
        return true
    }

    func setImage(_ url: URL, placeholder: UIImage?) {
        let options: KingfisherOptionsInfo = [
            .processor(SVGProcessor.default),
            .cacheSerializer(SVGCacheSerializer.default),
            .transition(.fade(0.3))
        ]
        kf.setImage(with: url, placeholder: placeholder, options: options )
    }

    func setImage(_ url: URL, placeholder: UIImage?, _ completionHandler: @escaping (UIImage) -> Void) {
        kf.setImage(with: url, placeholder: placeholder, completionHandler: { result in
            switch result {
            case let .success(value):
                completionHandler(value.image)
            case let .failure(error):
                sPrint(error)
            }
        })
    }

    func setCompressedImage(_ url: URL, placeholder: UIImage?, _: @escaping (UIImage) -> Void) {
        let processor = DownsamplingImageProcessor(size: bounds.size)

        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .processor(processor),
                .cacheOriginalImage,
            ]
        )
    }

    func setImageWithInitials(_ name: String?, _ backgroundColor: UIColor = .white) -> UIImage? {
        guard let name = name, !name.isEmpty else {
            image = nil
            return nil
        }

        let initials = name.initials
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        label.text = initials
        label.textAlignment = .center
        label.font = .SBFont.semiBold.font(18)
        label.textColor = .systemOrange
        label.backgroundColor = backgroundColor
        label.addCornerRadius(30)

        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
