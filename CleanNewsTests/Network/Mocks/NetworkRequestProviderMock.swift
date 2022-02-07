//
//  NetworkRequestProviderMock.swift
//  CleanNewsTests
//
//  Created by Afees Lawal on 02.02.22.
//

@testable import CleanNews
import Foundation

final class NetworkRequestProviderMock: NetworkRequestProvider {
    private let input: Result<Data, NetworkServiceError>

    init(input: Result<Data, NetworkServiceError>) {
        self.input = input
    }

    func request<T>(_: Endpoint, completion: @escaping (Result<T, NetworkServiceError>) -> Void) where T: Decodable {
        switch input {
        case let .success(data):
            guard let result: T = decode(data: data) else {
                return completion(.failure(.noResponse))
            }
            completion(.success(result))
        case let .failure(error):
            completion(.failure(error))
        }
    }

    private func decode<T: Decodable>(data: Data?) -> T? {
        do {
            guard let data = data else { return nil }
            let decoder = JSONDecoder()
            let result: T = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
    }
}
