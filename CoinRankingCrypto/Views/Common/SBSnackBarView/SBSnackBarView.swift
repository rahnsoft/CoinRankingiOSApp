
import UIKit

class SBSnackBarView: UIView {
    // MARK: IBOutlets

    @IBOutlet var outerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet private var view: UIView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var actionButton: UIButton!

    // MARK: Variables

    private var snackBarViewModel: SBSnackBarView.ViewModel

    // MARK: Closures

    private var confirmClosure: (() -> Void)?

    required init(_ viewModel: SBSnackBarView.ViewModel) {
        snackBarViewModel = viewModel
        super.init(frame: UIScreen.main.bounds)
        loadViewFromNib()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: IBActions

    @IBAction func confirmAction(_: Any) {
        closeView { _ in
            self.confirmClosure?()
        }
    }

    // MARK: Public methods

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self.view ? nil : view
    }

    func setConfirmClosure(_ confirmClosure: (() -> Void)?) {
        self.confirmClosure = confirmClosure
    }

    // MARK: Private methods

    private func loadViewFromNib() {
        view = UINib(nibName: "SBSnackBarView", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        outerView.backgroundColor = .white
        outerView.addCornerRadius(12)
        outerView.addShadow(1, .systemGray2)
        messageLabel.text = snackBarViewModel.messageText
        messageLabel.font = .SBFont.regular.font(12)
        messageLabel.textColor = .systemGray2
        actionButton.setTitleColor(.systemOrange, for: .normal)
        actionButton.titleLabel?.numberOfLines = .zero
        actionButton.titleLabel?.font = .SBFont.semiBold.font(14)
        imageView.image = snackBarViewModel.isSuccess ? UIImage(named: "Success_icon")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "exclamationmark.triangle.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = snackBarViewModel.isSuccess ? .systemOrange : .systemRed
        if snackBarViewModel.buttonText.isEmpty {
            actionButton.isHidden = true
        } else {
            actionButton.setTitle(snackBarViewModel.buttonText, for: .normal)
        }
        addSubview(view)
    }

    private func closeView(_ completion: @escaping ((Bool) -> Void)) {
        UIView.transition(with: superview ?? view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.removeFromSuperview()
        }, completion: completion)
    }
}

extension SBSnackBarView {
    struct ViewModel {
        var messageText: String
        var buttonText: String
        var isSuccess: Bool = false
    }
}
