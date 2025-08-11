//
//  OTPViewModel.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 13/05/2024.
//

import Foundation
import CoinRankingCryptoDomain
import RxRelay

class OTPViewModel: BaseViewModel {
    private var coordinator: OTPCoordinator?
    let countdown = PublishRelay<String?>()
    let buttonStatus = BehaviorRelay(value: SBButton.Status.disabled)
    let pinCode = BehaviorRelay(value: "")
    let passCode = BehaviorRelay(value: "")
    let displayErrors = BehaviorRelay(value: false)
    let pinError = BehaviorRelay(value: "")
    var isRequestOTPSucess = BehaviorRelay(value: true)
    var isLogin: Bool = false
    private let timer: TimerCountdown
    private var duration = 30

    override init() {
        timer = TimerCountdown(duration)
        super.init()
    }

    func setCoordinator(_ coordinator: OTPCoordinator) {
        self.coordinator = coordinator
    }
    
    func setIsLogin(_ isLogin: Bool) {
        self.isLogin = isLogin
    }

    func setPassCode(_ passCode: String) {
        self.passCode.accept(passCode)
    }

    // MARK: - Start Timer

    func startTimer() {
        timer.timerUpdate.subscribe(onNext: { [weak self] seconds in
            guard let self = self else { return }
            self.updateTimer(seconds)
        }).disposed(by: disposeBag)
        timer.start()
    }

    func stopTimer() {
        timer.stop()
    }

    // MARK: - Restart Timer

    func increaseDuration() {
        duration *= 2
    }

    func reStartTimer() {
        timer.updateSeconds(duration)
        timer.reset()
    }

    // MARK: - Update Timer

    private func updateTimer(_ seconds: Int) {
        guard seconds > 0 else {
            countdown.accept(nil)
            return
        }
        let countdownString = seconds < 10 ? "0\(seconds) sec" : "\(seconds) sec"
        countdown.accept(countdownString)
    }

    // MARK: - Setup Pin Code

    func setUpPinData(_ textFieldValue: String) {
        pinCode.accept(textFieldValue)
        if pinCode.value.count == 4 {
            buttonStatus.accept(.loading)
            verifyOTP()
        }
    }

    // MARK: - Verify OTP

    func verifyOTP() {
            self.goToHomeScreen()
    }

    // MARK: - Resend OTP

    func resendOTP() {

    }

    func goToLogin() {
        coordinator?.goToLogin()
    }

    func goToSetPassword() {
        coordinator?.goToSetPassword()
    }

    func goToHomeScreen() {
        coordinator?.goToHomeScreen()
    }
}
