//
//  HttpClient.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Alamofire
import Foundation

class HttpClient {
    private let baseURL: String
    private var headers: [String: String] = [:]

    required init(baseURL: String, headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
    }

    func setHeaders(headers: [String: String]) {
        self.headers = headers
    }

    func addHeaders(headers: [String: String]) {
        self.headers = self.headers.merging(headers, uniquingKeysWith: { first, _ in first })
    }

    func isConnectedToInternet() -> Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }

    func get<T: Decodable>(from url: String, resultType: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        if isConnectedToInternet() == false {
            completion(.failure(CommonError.networkError))
            return
        }
        guard let fullURL = URL(string: baseURL + url) else { return }
        AF.request(fullURL, method: .get).responseDecodable(of: resultType.self) { res in
            guard let statusCode = res.response?.statusCode else {
                print("StatusCode not found")
                completion(.failure(CommonError.serverError))
                return
            }
            switch statusCode {
            case 200 ... 299:
                guard let result = try? res.result.get() else {
                    print("Could not decode \(T.self)")
                    completion(.failure(CommonError.decodeError))
                    return
                }
                completion(.success(result))
            case 400:
                completion(.failure(CommonError.badRequest))
            case 401:
                completion(.failure(CommonError.unauthorized))
            case 403:
                completion(.failure(CommonError.forbidden))
            case 404:
                completion(.failure(CommonError.notFound))
            default:
                completion(.failure(CommonError.serverError))
            }
        }
    }
}
