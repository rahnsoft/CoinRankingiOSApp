
import UIKit

class KeyboardViewController: BaseViewController {
    private var keyboardHeight: CGFloat = 0
    private var isKeyboardVisible = false
    var constraintToUpdate: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        observeKeyboard()
    }

    private func observeKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func setKeyboardAvoidConstraint(_ constraintToUpdate: NSLayoutConstraint) {
        self.constraintToUpdate = constraintToUpdate
    }

    @objc func keyboardWillAppear(notification: NSNotification) {
        guard !isKeyboardVisible,
              let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let constraint = constraintToUpdate
        else {
            return
        }

        keyboardHeight = keyboardFrame.height
        isKeyboardVisible = true

        constraint.constant = -keyboardHeight - 8

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curve << 16),
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }

    @objc func keyboardWillDisappear(notification: NSNotification) {
        guard isKeyboardVisible,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let constraint = constraintToUpdate
        else {
            return
        }

        isKeyboardVisible = false
        constraint.constant = 0

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curve << 16),
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
