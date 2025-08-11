//
//  CustomUITextField.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 08/05/2024.
//

import MaterialComponents
import RxSwift
import UIKit

// MARK: - CustomUITextField

class CustomUITextField: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    // MARK: Internal

    @IBOutlet var view: UIView!
    @IBOutlet var uiTextField: LeftPaddedRightViewTextField!
    var disposeBag = DisposeBag()

    var viewModel: CustomUITextFieldModel? {
        didSet {
            configureViews()
        }
    }

    func configureViews() {
        let attributedPlaceholder = NSAttributedString(string: viewModel?.placeHolderText ?? "",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.label,
                                                                    NSAttributedString.Key.font: UIFont.SBFont.regular.font(14)])
        uiTextField.attributedPlaceholder = attributedPlaceholder
        addCornerRadius(8)
        uiTextField.textColor = .label
        uiTextField.font = .SBFont.semiBold.font(16)
        uiTextField.isSecureTextEntry = viewModel?.isSecureEntry ?? false
        uiTextField.keyboardType = viewModel?.keyboardType ?? .default
        uiTextField.tintColor = viewModel?.tintColor
        if let rightView = viewModel?.rightView {
            uiTextField.rightView = rightView
            uiTextField.rightViewMode = .always
        }
        if let leftView = viewModel?.leftView {
            uiTextField.leftView = leftView
            uiTextField.leftViewMode = .always
        }
        if viewModel?.becomeFirstResponder ?? false {
            uiTextField.becomeFirstResponder()
        }
        if let padding = viewModel?.padding {
            uiTextField.padding = padding
        }
    }

    @objc func rightTitleTapAction() {
        viewModel?.rightTitleLabelAction?()
    }

    func toggleIsSecureEntry() {
        uiTextField.isSecureTextEntry.toggle()
        uiTextField.isSelected.toggle()
    }

    // MARK: Private

    private func loadViewFromNib() {
        view = UINib(nibName: "CustomUITextField", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? UIView
        view.frame = bounds
        addSubview(view)
        configureViews()
    }
}

// MARK: CustomUITextField.CustomUITextFieldModel

extension CustomUITextField {
    struct CustomUITextFieldModel {
        var textFieldTitle: String
        var rightTextFieldTitle: String? = nil
        var rightTitleLabelAction: (() -> Void)?
        var isSecureEntry: Bool? = false
        var placeHolderText: String
        var keyboardType: UIKeyboardType
        var rightView: UIView?
        var leftView: UIView?
        var leftViewImage: UIImage?
        var borderColor: UIColor
        var borderWidth: Double
        var tintColor: UIColor
        var becomeFirstResponder: Bool
        var padding: UIEdgeInsets?
    }
}
