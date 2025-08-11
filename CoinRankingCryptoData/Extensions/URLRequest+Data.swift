//
//  URLRequest+Data.swift
//  CoinRankingCrypto
//
//  Created by Nicholas Wakaba on 09/02/2025.
//

import CoinRankingCryptoDomain
import Foundation

extension URLRequest {
    private static var baseUrl: String = {
        guard let plist = InfoConfigLoader.loadEnvironmentConfigPlist(),
              let baseUrl = plist["BaseUrl"] as? String
        else {
            sPrint("⚠️ Failed to load BaseUrl from plist, using default")
            return ""
        }
        return baseUrl
    }()

    init(_ endpoint: APIEndpoint, _ method: APIMethod, _ parameters: [String: Any?]? = nil, customHeaders: [String: String] = [:], _ urlArgs: CVarArg...) {
        let path = String(format: endpoint.rawValue, arguments: urlArgs)
        let urlString = URLRequest.urlResolver(for: endpoint, path: path)
        let url = URL(string: urlString)!
        self.init(url: url)
        httpMethod = method.rawValue
        processParameters(method, parameters)
        addValue("*/*", forHTTPHeaderField: "Accept")
        if customHeaders["Content-Type"] == nil {
            addValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        for (key, value) in customHeaders {
            addValue(value, forHTTPHeaderField: key)
        }

        if let accessToken = LoginLocalDataSource().getToken() {
            addValue(accessToken, forHTTPHeaderField: "x-access-token")
            sPrint("🏀 Bearer accessToken \(accessToken)")
        }

        timeoutInterval = 30

        sPrint("🚀 \(String(describing: parameters))")
        sPrint("🏀 url \(url)")
    }

    private static func urlResolver(for endPoint: APIEndpoint, path: String) -> String {
        switch endPoint.baseURL {
        default:
            return getNormalURL(path: path, base: endPoint.baseURL)
        }
    }

    private static func getNormalURL(path: String, base: APIEndpoint.BaseURL) -> String {
        switch base {
        case .default_url:
            return "\(baseUrl)\(path)"
        }
    }

    private mutating func processParameters(_ method: APIMethod, _ parameters: [String: Any?]? = nil) {
        switch method {
        case .get:
            processGetParameters(parameters)
        default:
            processPostParameters(parameters)
        }
    }

    private mutating func processPostParameters(_ parameters: [String: Any?]? = nil) {
        guard let parameters = parameters?.compactMapValues({ $0 }) else { return }

        let contentType = value(forHTTPHeaderField: "Content-Type")?.lowercased()

        if contentType == "application/x-www-form-urlencoded" {
            let formEncodedString = parameters.map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
            httpBody = formEncodedString.data(using: .utf8)
        } else {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                httpBody = jsonData
            }
        }
    }

    private mutating func processGetParameters(_ parameters: [String: Any?]? = nil) {
        guard let parameters = parameters?.compactMapValues({ $0 }) else { return }
        guard let baseURL = url?.absoluteString else { return }

        var queryItems: [String] = []

        for (key, value) in parameters {
            if let array = value as? [CustomStringConvertible] {
                for element in array {
                    let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    let encodedValue = String(describing: element)
                        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    queryItems.append("\(encodedKey)=\(encodedValue)")
                }
            } else {
                let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                let encodedValue = String(describing: value)
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                queryItems.append("\(encodedKey)=\(encodedValue)")
            }
        }

        let queryString = queryItems.joined(separator: "&")
        let fullURL = baseURL.contains("?") ? "\(baseURL)&\(queryString)" : "\(baseURL)?\(queryString)"
        url = URL(string: fullURL)
    }

    private mutating func processRequestObject(_ reqObject: Codable) {
        let encoder = JSONEncoder()

        if let json = try? JSONEncoder().encode(reqObject) {
            httpBody = json
        }
    }
}
