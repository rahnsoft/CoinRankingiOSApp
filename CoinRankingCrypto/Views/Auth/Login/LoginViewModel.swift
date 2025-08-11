//
//  LoginViewModel.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 10/02/2025.
//

import Foundation
import libPhoneNumber_iOS
import LocalAuthentication
import CoinRankingCryptoDomain
import RxRelay
import RxSwift

class LoginViewModel: BaseViewModel {
    private var coordinator: LoginCoordinator?
    var phoneNumber = BehaviorRelay(value: "")
    var isPhoneNumberValid = PublishRelay<Bool>()
    var password = BehaviorRelay(value: "")
    let buttonStatus = BehaviorRelay(value: false)
    private var isPasswordValid = BehaviorRelay(value: false)

    override init()
    {
        super.init()
        checkFieldsValidity()
    }

    func setCoordinator(_ coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }

    func checkFieldsValidity() {
        password
            .asObservable()
            .map { !$0.isEmpty }
            .bind(to: isPasswordValid)
            .disposed(by: disposeBag)

        Observable.combineLatest(isPasswordValid.asObservable(), isPhoneNumberValid.asObservable())
            .map { $0 && $1 }
            .bind(to: buttonStatus)
            .disposed(by: disposeBag)
    }
    
    func didUpdatePhone(_ number: String) {
        phoneNumber.accept(number.removeWhiteSpaces())
        toggleConfirmButton()
    }

    private func toggleConfirmButton() {
        let phone = NBPhoneNumberUtil().cleanPhoneNumber(phoneNumber.value)
        let isPhoneValid = phone.count == NBPhoneNumberUtil().maximumPhoneLength("KE")
        isPhoneNumberValid.accept(isPhoneValid)
    }

    func phoneLengthValid(_ newPhone: String) -> Bool {
        let phone = NBPhoneNumberUtil().cleanPhoneNumber(newPhone)
        return NBPhoneNumberUtil().isPhoneLengthValid(phone, "ke")
    }

    func login() {
                self.goToOTP()
    }

    func goToRegister() {
        coordinator?.goToRegister()
    }

    func goToOTP() {
        coordinator?.goToOTP(password.value)
    }

    func goToResetPassword() {
    }

    func goToBioMetrics() {
    }

    func goToHomeScreen() {
    }
}
