//
//  UseCase.swift
//  CleanNews
//
//  Created by Afees Lawal on 06.02.22.
//

import Combine
import Foundation

// MARK: - Use Case

typealias Completion<T> = (Result<T, Error>) -> Void
// Using the Command Pattern
protocol UseCase {
    associatedtype Params
    associatedtype Response
    func execute(completion: @escaping Completion<Response>)
    func execute(with params: Params, completion: @escaping Completion<Response>)
}

extension UseCase {
    func execute(completion _: @escaping Completion<Response>) {
        assertionFailure("This method should be overriden")
    }

    func execute(with _: Params, completion _: @escaping Completion<Response>) {
        assertionFailure("This method should be overriden")
    }
}

// MARK: - UseCaseExecutor

protocol UseCaseExecutor {
    func execute<U: UseCase, T>(_ useCase: U, completion: @escaping Completion<T>) where T == U.Response
    func execute<U: UseCase, P, T>(_ useCase: U, with params: P, completion: @escaping Completion<T>)
        where T == U.Response, P == U.Params
}

extension UseCaseExecutor {
    func execute<U: UseCase, T>(_ useCase: U) -> AnyPublisher<T, Error> where T == U.Response {
        Future<T, Error> { promise in
            self.execute(useCase) { result in
                switch result {
                case let .success(value):
                    promise(.success(value))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func execute<U: UseCase, P, T>(_ useCase: U, with params: P) -> AnyPublisher<T, Error>
        where T == U.Response, P == U.Params
    {
        Future<T, Error> { promise in
            self.execute(useCase, with: params) { result in
                switch result {
                case let .success(value):
                    promise(.success(value))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
