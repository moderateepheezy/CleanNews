//
//  NetworkServiceMock.swift
//  CleanNewsTests
//
//  Created by Afees Lawal on 03.02.22.
//

@testable import CleanNews
import Foundation

final class NetworkServiceMock: NetworkService {
    private let provider: NetworkRequestProviderMock

    init(provider: NetworkRequestProviderMock) {
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
