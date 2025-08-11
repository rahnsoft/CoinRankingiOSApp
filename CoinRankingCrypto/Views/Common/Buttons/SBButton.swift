
import SwiftUI
import UIKit
import RxSwift
import RxCocoa

class SBButton: UIView {
    enum Status {
        case enabled
        case disabled
        case loading
        case borderEnabled
        case borderDisabled
        case borderLoading
    }

    @IBOutlet var view: UIView!
    @IBOutlet var button: CustomButton!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    private let disposeBag = DisposeBag()

    var text: String = "" {
        didSet {
            if status != .loading {
                button.setTitle(text, for: .normal)
            }
        }
    }

    var buttonImage: UIImage? {
        didSet {
            if status != .loading {
                button.setImage(buttonImage, for: .normal)
            }
        }
    }

    var buttonImageSize: CGFloat {
        get {
            return button.imageView?.frame.size.height ?? 18
        }
        set {
            button.imageView?.frame.size = CGSize(width: newValue, height: newValue)
        }
    }

    var status: Status = .enabled {
        didSet {
            isUserInteractionEnabled = true
            button.backgroundColor = .systemOrange
            activityIndicatorView.stopAnimating()
            button.setTitle(text, for: .normal)
            button.setImage(buttonImage, for: .normal)
            switch status {
            case .disabled:
                isUserInteractionEnabled = false
                button.backgroundColor = .systemGray2
                addBorder(.clear, radius: 8, width: 1)
                setTextColor = .label
            case .loading:
                setLoading()
            case .borderEnabled:
                setBorder(true)
            case .borderDisabled:
                setBorder(false)
            case .enabled:
                setEnabled()
            case .borderLoading:
                setBorderLoading(true)
            }
        }
    }

    var setBackgroundColor: UIColor {
        get {
            return button.backgroundColor ?? .systemOrange
        }
        set {
            button.backgroundColor = newValue
            view.backgroundColor = newValue
        }
    }

    var setTintColor: UIColor {
        get {
            return button.tintColor ?? .label
        }
        set {
            button.tintColor = newValue
        }
    }

    var setTextColor: UIColor {
        get {
            return button.currentTitleColor
        }
        set {
            button.setTitleColor(newValue, for: .normal)
        }
    }

    var setFont: UIFont {
        get {
            return .SBFont.medium.font(14)
        }
        set {
            button.titleLabel?.font = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    fileprivate func configureViews() {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.titleLabel?.font = setFont
        button.layer.cornerRadius = 8
        view.layer.cornerRadius = 8
        button.backgroundColor = .systemOrange
        button.clipsToBounds = true
        view.layer.masksToBounds = false
    }

    func configureCornerRadius(_ radius: CGFloat = 8) {
        button.layer.cornerRadius = radius
        view.layer.cornerRadius = radius
        layer.cornerRadius = radius
    }

    private func loadViewFromNib() {
        view = UINib(nibName: "SBButton", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? UIView

        view.frame = bounds
        configureViews()
        addSubview(view)
    }

    private func setEnabled() {
        isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
        button.setTitle(text, for: .normal)
        button.setImage(buttonImage, for: .normal)
        setTextColor = .white
    }

    private func setDisabled() {
        isUserInteractionEnabled = false
        button.backgroundColor = .systemGray2
    }

    private func setLoading() {
        button.setTitle("", for: .normal)
        button.setImage(nil, for: .normal)
        isUserInteractionEnabled = false
        activityIndicatorView.startAnimating()
        setTextColor = .white
    }

    private func setBorderLoading(_ enabled: Bool) {
        setLoading()
        setBorder(enabled)
    }

    private func setBorder(_ enabled: Bool) {
        isUserInteractionEnabled = enabled
        setBackgroundColor = .systemOrange
        activityIndicatorView.color = .systemOrange
        layer.borderColor = UIColor.systemOrange.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = frame.height / 2
        setTextColor = enabled ? .systemOrange : .label
    }

    func addTarget(_ target: Any?, action: Selector) {
        button.rx.tap
            .subscribe(onNext: {
                (target as AnyObject).perform(action)
            })
            .disposed(by: disposeBag)
    }

    func removeTarget() {
        button.removeTarget(nil, action: nil, for: .allEvents)
    }

    func removeShadow() {
        view.layer.shadowColor = UIColor.clear.cgColor
    }
}

class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        // Calculate the frame for the image
        let imageSize: CGFloat = 18 // Adjust the size as needed
        let imageX: CGFloat = 0 // Adjust the x-position as needed
        let imageY: CGFloat = (bounds.height - imageSize) / 2 // Center the image vertically

        // Set the frame for the imageView
        imageView?.frame = CGRect(x: imageX, y: imageY, width: imageSize, height: imageSize)

        // Optionally, adjust the position and size of the title label
        titleLabel?.frame.origin.x = imageSize + 8 // Adjust the x-position of the title label
    }
}

struct SBButtonRepresentable: UIViewRepresentable {
    var title: String
    var cornerRadius: CGFloat = 12
    var height: CGFloat = 48
    var backgroundColor: UIColor = .systemOrange
    var titleColor: UIColor = .white
    var status: SBButton.Status = .enabled
    let action: () -> Void

    func makeUIView(context: Context) -> SBButton {
        let button = SBButton()
        button.text = title
        button.status = status
        button.configureCornerRadius(cornerRadius)
        button.setBackgroundColor = backgroundColor
        button.setTextColor = titleColor
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped))
        return button
    }

    func updateUIView(_ uiView: SBButton, context: Context) {
        uiView.text = title
        uiView.status = status
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }

    class Coordinator: NSObject {
        let action: () -> Void

        init(action: @escaping () -> Void) {
            self.action = action
        }

        @objc func buttonTapped() {
            action()
        }
    }
}
