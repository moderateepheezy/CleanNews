//
//  NetworkRequestProvider.swift
//  CleanNews
//
//  Created by Afees Lawal on 15.01.22.
//

import Foundation
import Moya

protocol NetworkRequestProvider {
    func request<T: Decodable>(_ request: Endpoint, completion: @escaping (Swift.Result<T, NetworkServiceError>) -> Void)
}

class MoyaNetworkRequestProvider: NetworkRequestProvider {
    private lazy var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin.verbose])

    func request<T>(_ request: Endpoint, completion: @escaping (Swift.Result<T, NetworkServiceError>) -> Void) where T: Decodable {
        provider.request(MultiTarget(request)) {
            switch $0 {
            case let .success(result):
                guard let result: T = self.decode(data: result.data) else {
                    completion(.failure(.noResponse))
                    return
                }
                completion(.success(result))
            case let .failure(error):
                let networkError = self.resolve(error: error)
                let serviceError = self.resolve(networkError: networkError)
                completion(.failure(serviceError))
            }
        }
    }

    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }

    private func resolve(networkError error: NetworkError) -> NetworkServiceError {
        let resolvedError: Error = error
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }

    private func decode<T: Decodable>(data: Data?) -> T? {
        do {
            guard let data = data else { return nil }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result: T = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
    }
}
