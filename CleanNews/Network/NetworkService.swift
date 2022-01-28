//
//  NetworkService.swift
//  CleanNews
//
//  Created by Afees Lawal on 15.01.22.
//

import Foundation
import Moya

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

enum NetworkServiceError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol NetworkService {
    typealias NetworkRequestCompletion<T> = (Swift.Result<T, Error>) -> Void
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion<T>)
}

class CleanNetworkService: NetworkService {
    private let provider = NetworkRequestProvider()
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func request<T>(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion<T>) where T: Decodable {
        provider.request(endpoint) { (result: Result<T, Error>) in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
