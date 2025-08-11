
import Alamofire
import CoinRankingCryptoDomain
import RxSwift

class BaseRemoteDataSource {
    private let api: APIClient
    init() {
        api = APIClient()
    }

    func apiRequest<T: Codable>(_ urlRequest: URLRequest, isSecondTryAfterAuth: Bool = false, isThirdTryAfterBearer: Bool = false) -> Single<(T, HTTPURLResponse)> {
        return api.request(urlRequest).catch { [unowned self] error in
            if let sbError = getSBError(error) {
                switch sbError {
                case .unauthorized:
                        return Single.error(error)
                case .invalidPin:
                    return Single.error(SBErrors.invalidPin)

                default:
                    return Single.error(error)
                }
            } else {
                return Single.create(subscribe: { [unowned self] single -> Disposable in
                    if let sbError = parseError(error) {
                        single(.failure(sbError))
                    } else {
                        single(.failure(error))
                    }
                    return Disposables.create()
                })
            }
        }
    }

    func apiRequest(_ urlRequest: URLRequest, isSecondTryAfterAuth: Bool = false, isThirdTryAfterBearer: Bool = false) -> Single<HTTPURLResponse> {
        return api.request(urlRequest).catch { [unowned self] error in

            if let sbError = getSBError(error) {
                switch sbError {
                case .invalidPin,
                     .unauthorized:
                    return Single.error(error)
                case .userNotFound:
                    return Single.error(SBErrors.userNotFound)

                default:
                    return Single.error(error)
                }

            } else {
                return singleError(error: error)
            }
        }
    }

    private func parseError(_ error: Error) -> SBErrors? {
        return getSBError(error)
    }

    private func getSBError(_ error: Error) -> SBErrors? {
        guard case let SBErrors.apiError(code, message, reason, dict) = error else {
            return nil
        }
        switch code {
        case 406:
            return SBErrors.unauthorized

        case 401:
            if message.count > 0 {
                return SBErrors.apiError(code: code, message: message, reason: reason, dict: dict)
            }
            return SBErrors.unauthorized

        case 403:
            return SBErrors.userBlacklisted

        case 404:
            return SBErrors.userNotFound

        default:
            return nil
        }
    }

    private func singleError(error: Error) -> Single<HTTPURLResponse> {
        return Single.create(subscribe: { [unowned self] single -> Disposable in
            if let sbError = parseError(error) {
                single(.failure(sbError))
            } else {
                single(.failure(error))
            }
            return Disposables.create()
        })
    }
}
