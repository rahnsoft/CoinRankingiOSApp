//
//  LoginView.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wambui on 10/29/24.
//

import UIKit

class LoginView: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Get_started_1")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var loginTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.semiBold.font(24)
        label.textColor = .label
        label.text = Strings.authSignIn.localized()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var emailAddress: CustomTextField = {
        let textField = CustomTextField()
        let customUITextFieldModel = CustomTextField.Model(
            placeHolderText: Strings.authPhoneNumber.localized(),
            holderText: Strings.authSignUpPlaceHolder.localized(),
            leftIconName: "Phone_number_icon",
            keyboardType: .numberPad,
            textContentType: .telephoneNumber,
            becomeFirstResponder: false
        )
        textField.mDCTextField.autocorrectionType = .no
        textField.mDCTextField.autocapitalizationType = .none
        textField.tag = 1
        textField.uiModel = customUITextFieldModel
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var password: CustomTextField = {
        let textField = CustomTextField()
        let customUITextFieldModel = CustomTextField.Model(
            placeHolderText: Strings.authPinPassword.localized(),
            leftIconName: "Password_image",
            rightIconName: UIImage(systemName: "eye.slash"),
            keyboardType: .default,
            textContentType: .password,
            becomeFirstResponder: false,
            rightRenderingOption: .alwaysTemplate,
            isSecureTextEntry: true
        )
        textField.tag = 2
        textField.uiModel = customUITextFieldModel
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.authForgotPassword.localized(), for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .SBFont.medium.font(12)
        button.titleLabel?.textAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var continueButton: SBButton = {
        let button = SBButton()
        button.status = .disabled
        button.text = Strings.authSignIn.localized()
        button.configureCornerRadius(8)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var biometricButton: SBButton = {
        let button = SBButton()
        button.text = Strings.authBioLogin.localized().uppercased()
        button.configureCornerRadius(8)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: Strings.authDontHaveAccount.localized(with: Strings.authSignUpHere.localized()))
        attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.font, value: UIFont.SBFont.medium.font(14), range: NSRange(location: 0, length: attributedString.length))
        attributedString.changeFont([Strings.authSignUpHere.localized()], font: UIFont.SBFont.medium.font(14), textColor: .systemOrange)
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(imageView)
        addSubview(loginTitleLabel)
        addSubview(emailAddress)
        addSubview(password)
        addSubview(forgotPasswordButton)
        addSubview(continueButton)
        addSubview(signUpLabel)

        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(280)
            make.width.equalTo(260)
        }

        loginTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(emailAddress.snp.top).offset(-24)
        }

        emailAddress.snp.makeConstraints { make in
            make.top.equalTo(loginTitleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(password.snp.top).offset(-16)
        }

        password.snp.makeConstraints { make in
            make.top.equalTo(emailAddress.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(forgotPasswordButton.snp.top).offset(-8)
        }

        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(continueButton.snp.top).offset(-8)
        }

        continueButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }

        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
