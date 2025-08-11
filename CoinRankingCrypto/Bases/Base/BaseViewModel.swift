
import CoinRankingCryptoDependencyInjection
import CoinRankingCryptoDomain
import RxCocoa
import RxSwift
import WidgetKit

class BaseViewModel: RxBaseProtocol {
    let disposeBag = DisposeBag()
    let errorRelay = PublishRelay<Error>()
    let successRelay = PublishRelay<String>()
    let loadingRelay = PublishRelay<Bool>()    
    
    func handleError(_ error: Error, _ retryAction: @escaping (() -> Void)) {
        switch error {
        case SBErrors.invalidRefreshToken:
            logout()
        default:
            errorRelay.accept(parseApiErrorToRetry(error, retryAction))
        }
    }
    
    private func parseApiErrorToRetry(_ error: Error, _ retryAction: @escaping (() -> Void)) -> Error {
        switch error {
        case let SBErrors.apiError(_, message, _, _):
            return SBErrors.retryError(message: message, retryAction: retryAction)
        case SBErrors.internetError:
            return SBErrors.retryError(message: Strings.commonInternetError.localized(), retryAction: retryAction)
        case SBErrors.timeout:
            return SBErrors.retryError(message: Strings.commonGeneralError.localized(), retryAction: retryAction)
        case SBErrors.invalidUser:
            return SBErrors.retryError(message: Strings.invalidPhoneNumberError.localized(), retryAction: retryAction)
        case SBErrors.invalidVerificationCode:
            return SBErrors.retryError(message: "Wrong credentials!!", retryAction: retryAction)
        default:
            return error
        }
    }
    
    func showErrorMessageToRetry(_ errorMessage: String, _ retryAction: @escaping (() -> Void)) {
        errorRelay.accept(SBErrors.retryError(message: errorMessage, retryAction: retryAction))
    }
    
    func showErrorMessage(_ errorMessage: String, _ retryAction: @escaping (() -> Void)) {
        errorRelay.accept(SBErrors.retryError(message: errorMessage, retryAction: retryAction))
    }
    
    private func logout() {
        guard let _ = appWindow else { return }
        //        LoginCoordinator(nil, window).start()
    }
    
}
