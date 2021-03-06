//
//  NetworkService.swift
//  CleanNews
//
//  Created by Afees Lawal on 15.01.22.
//

import Foundation
import Moya

protocol NetworkService {
    typealias NetworkRequestCompletion<T> = (Swift.Result<T, Error>) -> Void
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion<T>)
}

class CleanNetworkService: NetworkService {
    private let provider: NetworkRequestProvider

    init(provider: NetworkRequestProvider) {
        self.provider = provider
    }

    func request<T>(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion<T>) where T: Decodable {
        provider.request(endpoint) { (result: Result<T, NetworkServiceError>) in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
