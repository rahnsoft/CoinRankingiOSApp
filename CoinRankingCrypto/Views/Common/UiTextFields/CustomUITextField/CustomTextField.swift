//
//  CustomTextField.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 18/02/2025.
//

import MaterialComponents
import RxSwift
import UIKit

class CustomTextField: UIView {
    // MARK: - Public Properties

    var dropdownOptions: [String] = []
    var onOptionSelected: ((String) -> Void)?
    var disableKeyboard: Bool = false

    // MARK: - UI Components

    lazy var mDCTextField: MDCFilledTextField = {
        let mTxt = MDCFilledTextField()
        mTxt.setFilledBackgroundColor(.systemGray2, for: .disabled)
        mTxt.addCornerRadius(8)
        mTxt.setUnderlineColor(.clear, for: .normal)
        mTxt.setUnderlineColor(.clear, for: .editing)
        mTxt.setUnderlineColor(.clear, for: .disabled)
        mTxt.translatesAutoresizingMaskIntoConstraints = false
        return mTxt
    }()

    var trailingIcon = UIImageView()
    var leadingIcon = UIImageView()

    var uiModel: Model? {
        didSet { applyModel() }
    }

    override var canBecomeFirstResponder: Bool {
        return !disableKeyboard
    }

    var hasError: Bool = false {
        didSet { updateBorderColor() }
    }

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configureView()
        addListeners()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configureView() {
        backgroundColor = .clear
        addSubview(mDCTextField)
        mDCTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addListeners() {
        mDCTextField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        mDCTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }

    private func applyModel() {
        guard let model = uiModel else { return }

        // Leading icon or view
        if let iconName = model.leftIconName {
            leadingIcon.image = UIImage(named: iconName)?.withRenderingMode(model.leftRenderingOption)
            leadingIcon.contentMode = .scaleAspectFit
            leadingIcon.tintColor = model.leftIconTintColor
            leadingIcon.frame = CGRect(x: 0, y: 0, width: model.leftIconSize, height: model.leftIconSize)
            mDCTextField.leadingView = leadingIcon
            mDCTextField.leadingViewMode = .always
        } else if let leftView = model.leftView {
            mDCTextField.leadingView = leftView
            mDCTextField.leadingViewMode = .always
        } else {
            mDCTextField.leadingView = nil
            mDCTextField.leadingViewMode = .never
        }

        // Trailing icon or view
        if let rightIcon = model.rightIconName {
            trailingIcon.image = rightIcon.withRenderingMode(model.rightRenderingOption)
            trailingIcon.contentMode = .scaleAspectFit
            trailingIcon.tintColor = model.rightIconTintColor
            trailingIcon.frame = CGRect(x: 0, y: 0, width: model.rightIconSize, height: model.rightIconSize)

            mDCTextField.trailingView = trailingIcon
            mDCTextField.trailingViewMode = .always
            mDCTextField.trailingView?.isUserInteractionEnabled = true

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trailingIconTapped))
            mDCTextField.trailingView?.addGestureRecognizer(tapGesture)
        } else if let rightView = model.rightView {
            mDCTextField.trailingView = rightView
            mDCTextField.trailingViewMode = .always
            mDCTextField.trailingView?.isUserInteractionEnabled = true
        } else {
            mDCTextField.trailingView = nil
            mDCTextField.trailingViewMode = .never
        }

        // Text and style
        mDCTextField.label.text = model.placeHolderText
        if !model.holderText.isEmpty {
            mDCTextField.attributedPlaceholder = NSAttributedString(
                string: model.holderText,
                attributes: [.foregroundColor: model.textColor, .font: model.font]
            )
        }

        mDCTextField.label.font = model.font
        mDCTextField.label.textColor = model.textColor
        mDCTextField.font = model.font
        mDCTextField.textColor = model.textColor
        mDCTextField.isSecureTextEntry = model.isSecureTextEntry
        mDCTextField.keyboardType = model.keyboardType
        mDCTextField.textContentType = model.textContentType
        mDCTextField.setFilledBackgroundColor(model.backgroundColor, for: .normal)
        mDCTextField.setFilledBackgroundColor(model.backgroundColor, for: .editing)

        if disableKeyboard {
            mDCTextField.inputView = UIView()
        }

        if model.becomeFirstResponder {
            mDCTextField.becomeFirstResponder()
        }
        
        setBorderColorForNormal()
    }

    // MARK: - Actions

    @objc private func trailingIconTapped() {
        if !dropdownOptions.isEmpty {
//            dropdownIconTapped()
        } else if uiModel?.isSecureTextEntry == true {
            toggleIsSecureEntry()
        }
    }

    @objc private func toggleIsSecureEntry() {
        mDCTextField.isSecureTextEntry.toggle()
        trailingIcon.image = mDCTextField.isSecureTextEntry
            ? UIImage(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate)
            : UIImage(systemName: "eye")?.withRenderingMode(.alwaysTemplate)
        trailingIcon.tintColor = uiModel?.rightIconTintColor ?? .label
    }

    @objc private func editingDidBegin() {
        setBorderColorForEditing()
    }

    @objc private func editingDidEnd() {
        hasError ? setBorderColorForError() : setBorderColorForNormal()
    }

    // MARK: - Border Handling

    func setBorderColorForEditing() {
        mDCTextField.layer.borderWidth = 1.0
        mDCTextField.layer.borderColor = UIColor.systemGray2.cgColor
    }

    func setBorderColorForNormal() {
        mDCTextField.layer.borderWidth = 1.0
        mDCTextField.layer.borderColor = UIColor.systemGray2.cgColor
    }

    func setBorderColorForError() {
        mDCTextField.layer.borderWidth = 1.0
        mDCTextField.layer.borderColor = UIColor.systemRed.cgColor
    }

    private func updateBorderColor() {
        hasError ? setBorderColorForError() : setBorderColorForNormal()
    }

    // MARK: - Model

    struct Model {
        var placeHolderText: String
        var holderText: String = ""
        var leftView: UIView?
        var leftIconName: String?
        var rightView: UIView?
        var rightIconName: UIImage?
        var leftIconTintColor: UIColor = .label
        var rightIconTintColor: UIColor = .label
        var keyboardType: UIKeyboardType = .default
        var textContentType: UITextContentType?
        var becomeFirstResponder: Bool = false
        var textColor: UIColor = .label
        var font: UIFont = UIFont.SBFont.medium.font(12)
        var leftIconSize: CGFloat = 14
        var rightIconSize: CGFloat = 22
        var leftRenderingOption: UIImage.RenderingMode = .alwaysTemplate
        var rightRenderingOption: UIImage.RenderingMode = .alwaysTemplate
        var isSecureTextEntry: Bool = false
        var backgroundColor: UIColor = .clear
    }
}
