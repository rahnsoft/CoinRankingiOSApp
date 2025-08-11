//
//  LoginViewController.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wambui on 10/29/24.
//

import IQKeyboardManagerSwift
import LocalAuthentication
import CoinRankingCryptoDomain
import UIKit
import RxSwift
import RxGesture

class LoginViewController: KeyboardViewController {
    lazy var loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var viewModel: LoginViewModel

    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureObservables()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 160
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func keyboardWillAppear(notification: NSNotification) {
        super.keyboardWillAppear(notification: notification)

        let imageView = loginView.imageView

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            imageView.alpha = 0
        })
    }

    override func keyboardWillDisappear(notification: NSNotification) {
        super.keyboardWillDisappear(notification: notification)

        let imageView = loginView.imageView

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            imageView.alpha = 1
        })
    }

    func configureView() {
        view.addSubview(loginView)

        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureObservables() {
        loginView.emailAddress.mDCTextField.rx.text.orEmpty.asObservable().subscribe(onNext: { [weak self] text in
            guard let self = self else { return }
            self.viewModel.didUpdatePhone(text)
        }).disposed(by: disposeBag)

        loginView.password.mDCTextField.rx.text.orEmpty.asObservable().bind(to: viewModel.password).disposed(by: disposeBag)

        loginView.forgotPasswordButton.rx.tap.asDriver().drive { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.goToResetPassword()
        }.disposed(by: disposeBag)

        loginView.signUpLabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.goToRegister()
        }).disposed(by: disposeBag)

        loginView.continueButton.button.rx.tap.asDriver().drive { [weak self] _ in
            guard let self = self else { return }
            self.view.endEditing(true)
            self.viewModel.login()
        }.disposed(by: disposeBag)

        loginView.biometricButton.button.rx.tap.asDriver().drive { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.goToBioMetrics()
        }.disposed(by: disposeBag)

        viewModel.buttonStatus.subscribe(onNext: { [weak self] isShow in
            guard let self = self else { return }
            self.loginView.continueButton.status = isShow ? .enabled : .disabled
        }).disposed(by: disposeBag)

        viewModel.loadingRelay.subscribe { [weak self] isLoading in
            guard let self = self else { return }
            self.loginView.continueButton.status = isLoading ? .loading : .enabled
            self.loginView.biometricButton.configureCornerRadius(8)
        }.disposed(by: disposeBag)

        viewModel.errorRelay.subscribe(onNext: { [weak self] error in
            guard let self = self else { return }
            self.showSnackError(error)
        }).disposed(by: disposeBag)
    }
}
