
import MaterialComponents
import UIKit

extension UIView {
    func addCornerRadiusAndShadow(_ cornerRadius: CGFloat = 10, shadowSize: CGFloat = 1) {
        layer.cornerRadius = cornerRadius
        addShadow(shadowSize)
    }

    func addCornerRadius(_ radius: CGFloat = 10) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }

    func addCapsuleRadius() {
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }

    func addShadow(_ size: CGFloat = 1, _ color: UIColor = .label) {
        layer.masksToBounds = false
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: size, height: size)
        layer.shadowOpacity = 0.3
    }

    func addShadowBottom() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 8
    }

    func addCornerRadius(_ corners: UIRectCorner, _ radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func addBorder(_ color: UIColor, width: CGFloat = 1.0) {
        layer.cornerRadius = frame.size.height / 2
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func addBorder(_ color: UIColor, radius: CGFloat, width: CGFloat = 1.0) {
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func addTopBorder(_ color: UIColor, width: CGFloat = 1.0) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        addSubview(border)
    }

    func addGradient(_ colors: [CGColor], locations: [NSNumber]?) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = colors
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func pinToSuperview(withEdges edges: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: edges.left),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -edges.right),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: edges.top),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -edges.bottom),
        ])
    }

    func animatedScale(_ x: CGFloat, _ y: CGFloat) {
        let minimumScale: CGFloat = 0.000000000000001
        let xScale: CGFloat = x != 0 ? x : minimumScale
        let yScale: CGFloat = y != 0 ? y : minimumScale
        guard xScale != transform.a || yScale != transform.d else {
            return
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.transform = .init(scaleX: xScale, y: yScale)
        }
    }

    func fadeIn() {
        animatedAlpha(1)
    }

    func fadeOut() {
        animatedAlpha(0)
    }

    private func animatedAlpha(_ alpha: CGFloat) {
        guard alpha != self.alpha else {
            return
        }
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = alpha
        })
    }

    func applyTransform(_ scale: CGFloat, _ anchorPoint: CGPoint) {
        layer.anchorPoint = anchorPoint
        let scale = scale != 0 ? scale : CGFloat.leastNonzeroMagnitude
        let xPadding = 1 / scale * (anchorPoint.x - 0.5) * bounds.width
        let yPadding = 1 / scale * (anchorPoint.y - 0.5) * bounds.height
        transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: xPadding, y: yPadding)
    }

    func addDashedBorder(_ color: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

    func setBackgroundImage(image: UIImage?) {
        guard let backgroundImage = image else {
            return
        }

        let backgroundImageView = UIImageView(frame: bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
    }

    func dashedLineSeparatorForView() -> CAShapeLayer {
        let dashedLine = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.height - 1))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height - 1))

        dashedLine.path = path.cgPath
        dashedLine.strokeColor = UIColor.systemGray2.cgColor
        dashedLine.lineWidth = 1
        dashedLine.lineDashPattern = [6, 3]

        return dashedLine
    }
}
