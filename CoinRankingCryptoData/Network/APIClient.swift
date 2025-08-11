//
//  APIClient.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 09/02/2025.
//

import Alamofire
import enum CoinRankingCryptoDomain.SBErrors
import RxAlamofire
import RxSwift
#if DEBUG
import CoinRankingCryptoDomain
import Foundation
import Log
#endif

// MARK: - DateError

enum DateError: String, Error {
    case invalidDate
}

// MARK: - APIClient

public class APIClient {
    private var sessionManager: Session
#if DEBUG
    let log: Logger = .init()
#endif

    public init() {
        sessionManager = Session()
    }

    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] observer -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { response, urlResponse in
                    observer(.success((response, urlResponse)))
                }, { error in
                    observer(.failure(error))
                })
            } else {
                observer(.failure(SBErrors.internetError))
                return Disposables.create()
            }
        })
    }

    func request(_ urlRequest: URLRequest) -> Single<HTTPURLResponse> {
        return Single.create(subscribe: { [unowned self] observer -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { urlResponse in
                    observer(.success(urlResponse))
                }, { error in
                    observer(.failure(error))
                })
            } else {
                observer(.failure(SBErrors.internetError))
                return Disposables.create()
            }
        })
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest,
                                       _ responseHandler: @escaping (T, HTTPURLResponse) -> Void,
                                       _ errorHandler: @escaping ((_ error: SBErrors) -> Void)) -> Disposable
    {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                guard let httpUrlResponse = response.response else {
                    return
                }
                let statusCode = httpUrlResponse.statusCode
                if 200..<300 ~= statusCode {
                    self.decodeResponse(response, responseHandler)
                } else {
                    guard let data = response.data else { return }
                    self.decode(data, statusCode: statusCode, errorHandler)
                }
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func request(_ urlRequest: URLRequest,
                         _ responseHandler: @escaping (HTTPURLResponse) -> Void,
                         _ errorHandler: @escaping ((_ error: SBErrors) -> Void)) -> Disposable
    {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseData()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] httpUrlResponse, data in
                if 200..<300 ~= httpUrlResponse.statusCode {
                    responseHandler(httpUrlResponse)
                } else {
                    guard let self = self else { return }
                    self.logError(urlRequest, response: httpUrlResponse)
                    self.decode(data, statusCode: httpUrlResponse.statusCode, errorHandler)
                }
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func decode(_ data: Data, statusCode: Int, _ errorHandler: (_ error: SBErrors) -> Void) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let errorResponse = try JSONDecoder().decode(GenericResponse<EmptyBody>.self, from: data)
            errorHandler(SBErrors.apiError(code: statusCode,
                                           message: errorResponse.message ?? "",
                                           reason: errorResponse.type ?? "",
                                           dict: [:]))
        } catch {
            errorHandler(.parseData)
        }
    }

    private func decodeResponse<T: Decodable>(_ response: DataResponse<Any, AFError>,
                                              _ responseHandler: @escaping (T, HTTPURLResponse) -> Void)
    {
        if let jsonData = response.data, let httpUrlResponse = response.response {
            sPrint("Request response  \(response.request?.urlRequest)")

            if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
                sPrint("The Json is", jsonObject)
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom { decoder -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)

                    if let date = DateFormatter.iso8601Formatter.date(from: dateStr) {
                        return date
                    }
                    if let date = DateFormatter.iso8601MillisecondsFormatter.date(from: dateStr) {
                        return date
                    }
                    if let date = DateFormatter.iso8601SecondsFormatter.date(from: dateStr) {
                        return date
                    }
                    throw DateError.invalidDate
                }
                try responseHandler(decoder.decode(T.self, from: jsonData), httpUrlResponse)
            } catch {
                sPrint("Decoding error: \(error), \(T.self)")
            }
        }
    }

    func logError(_ urlRequest: URLRequest, response: HTTPURLResponse) {
#if DEBUG
        log.error(urlRequest)
        log.error(urlRequest.allHTTPHeaderFields ?? [:])
        log.error(response)
#endif
    }
}
