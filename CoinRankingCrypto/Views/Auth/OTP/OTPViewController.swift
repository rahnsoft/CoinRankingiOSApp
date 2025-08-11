//
//  OTPViewController.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 13/05/2024.
//

import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import RxCocoa
import RxSwift
import SnapKit
import UIKit

// MARK: - OTPViewController

class OTPViewController: KeyboardViewController {
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            verifyLabel,
            enterCodeLabel,
            otpTextField,
            didntReceiveCodeLabel,
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.setCustomSpacing(32, after: didntReceiveCodeLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var verifyLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.welcomeOnboard.localized()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .SBFont.semiBold.font(24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var enterCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.regular.font(14)
        label.textColor = .label
        label.numberOfLines = .zero
        label.textAlignment = .center
        let phoneNumber =  "0712345678"
        let title = Strings.weSentOtp.localized(with: " " + phoneNumber.obfuscatePhoneNumber())
        let attributedText = NSMutableAttributedString(string: title)
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 18.4
        style.alignment = .center
        let range = NSRange(location: 0, length: title.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.SBFont.regular.font(14),
                                      NSAttributedString.Key.foregroundColor: UIColor.systemGray2], range: range)
        attributedText.changeFont([phoneNumber], font: .SBFont.semiBold.font(16))
        label.numberOfLines = 0
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var otpTextField: OTPFieldView = {
        let field = OTPFieldView()
        field.fieldsCount = 4
        field.fieldFont = .SBFont.semiBold.font(24)
        field.otpInputType = .numeric
        field.displayType = .roundedCorner
        field.fieldSize = 50
        field.separatorSpace = 16
        field.defaultBorderColor = .systemGray2
        field.cursorColor = .systemOrange
        field.shouldAllowIntermediateEditing = true
        field.defaultBackgroundColor = .clear
        field.filledBackgroundColor = .clear
        field.fieldBorderWidth = 1
        field.filledBorderColor = .systemGray2
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var didntReceiveCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .SBFont.regular.font(14)
        label.textColor = .label
        label.text = Strings.authDidNotReceiveCodeSendAgainIn.localized(with: "30 sec")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var verifyOTPButton: SBButton = {
        let button = SBButton()
        button.status = .disabled
        button.text = Strings.commonVerify.localized()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var verifyButtonBottomConstraint: NSLayoutConstraint?

    private var viewModel: OTPViewModel

    init(_ viewModel: OTPViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureObservables()
    }

    // MARK: - Configure view

    func configureView() {
        view.addSubview(stackView)
        view.addSubview(verifyOTPButton)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        otpTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        verifyOTPButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        verifyButtonBottomConstraint = verifyOTPButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        verifyButtonBottomConstraint?.isActive = true
        setKeyboardAvoidConstraint(verifyButtonBottomConstraint!)

        viewModel.startTimer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Configure Observables

    func configureObservables() {
        viewModel.isRequestOTPSucess
            .asObservable()
            .subscribe(onNext: { [unowned self] enabled in
                if !enabled {
                    self.viewModel.stopTimer()
                    let didntReceiveCodeLabelText = Strings.authWrongOtpCode.localized()
                    let attributedString = NSMutableAttributedString(string: didntReceiveCodeLabelText)
                    didntReceiveCodeLabel.font = .SBFont.regular.font(14)
                    didntReceiveCodeLabel.textColor = .systemRed
                    attributedString.changeFont([Strings.commonSendAgain.localized()], font: .SBFont.semiBold.font(14), textColor: .systemOrange, underLineStyle: .thick)
                    didntReceiveCodeLabel.attributedText = attributedString
                    self.verifyOTPButton.status = .disabled
                    self.otpTextField.errorBorderColor = .systemRed
                    self.otpTextField.isOTPValid = false
                }
            }).disposed(by: disposeBag)

        viewModel.buttonStatus
            .asDriver().drive { [weak self] status in
                guard let self = self else { return }
                self.verifyOTPButton.status = status
                self.verifyOTPButton.button.isEnabled = status != .disabled
            }.disposed(by: disposeBag)

        didntReceiveCodeLabel.rx.tapGesture().when(.recognized).asObservable().subscribe { [weak self] _ in
            guard let self = self else { return }
            self.otpTextField.clearAllTextFields()
            self.viewModel.pinCode.accept("")
            self.viewModel.reStartTimer()
            self.viewModel.resendOTP()
        }.disposed(by: disposeBag)

        verifyOTPButton.button.rx.tap.asDriver().drive(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewModel.verifyOTP()
        }).disposed(by: disposeBag)

        viewModel.countdown.observe(on: MainScheduler.instance).subscribe(onNext: countdownUpdated).disposed(by: disposeBag)

        viewModel.loadingRelay.subscribe { [weak self] isLoading in
            guard let self = self else { return }
            self.updateLoading(isLoading, self.view)
        }.disposed(by: disposeBag)

        viewModel.errorRelay.subscribe(onNext: { [weak self] error in
            guard let self = self else { return }
            self.showSnackError(error)
        }).disposed(by: disposeBag)

        viewModel.successRelay.subscribe(onNext: { [weak self] message in
            guard let self = self else { return }
            self.showSuccessMessage(message)
        }).disposed(by: disposeBag)
    }

    // MARK: - Show Countdown Updated on the UILabel

    private func countdownUpdated(_ seconds: String?) {
        let didntReceiveCodeLabelText = seconds != nil ? Strings.authDidNotReceiveCodeSendAgainIn.localized(with: seconds ?? "") : Strings.authDidNotReceiveCodeSendAgain.localized()
        let attributedString = NSMutableAttributedString(string: didntReceiveCodeLabelText)
        didntReceiveCodeLabel.font = .SBFont.regular.font(14)
        didntReceiveCodeLabel.textColor = .systemGray2
        if seconds == nil {
            attributedString.changeFont([Strings.commonSendAgain.localized()], font: .SBFont.semiBold.font(14), textColor: .systemOrange, underLineStyle: .thick)
        }
        didntReceiveCodeLabel.attributedText = attributedString
    }
}

// MARK: OTPFieldViewDelegate

extension OTPViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex _: Int) -> Bool {
        return true
    }

    // MARK: Called when has entered all the code

    func enteredOTP(otp: String) {
        view.endEditing(true)
        viewModel.setUpPinData(otp)
    }

    // MARK: Returns a bool true or false if all text has been entered

    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        verifyOTPButton.status = hasEnteredAll ? .loading : .disabled
        if !(viewModel.isRequestOTPSucess.value), !hasEnteredAll {
            countdownUpdated(nil)
            otpTextField.isOTPValid = true
        }
        return hasEnteredAll
    }
}
