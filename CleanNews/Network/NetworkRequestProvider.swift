//
//  NetworkRequestProvider.swift
//  CleanNews
//
//  Created by Afees Lawal on 15.01.22.
//

import Foundation
import Moya

class NetworkRequestProvider {
    lazy var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin.verbose])

    func request<T>(_ request: Endpoint, completion: @escaping (Swift.Result<T, Error>) -> Void) where T: Decodable {
        provider.request(MultiTarget(request)) {
            switch $0 {
            case let .success(result):
                guard let result: T = self.decode(data: result.data) else {
                    completion(.failure(NetworkServiceError.noResponse))
                    return
                }
                completion(.success(result))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func decode<T: Decodable>(data: Data?) -> T? {
        do {
            guard let data = data else { return nil }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result: T = try decoder.decode(T.self, from: data)
            return result
        } catch { error
            print(error)
            return nil
        }
    }
}

struct APIKeyPlugin: PluginType {
    let token: String

    func prepare(_ request: URLRequest, target _: TargetType) -> URLRequest {
        var request = request
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
