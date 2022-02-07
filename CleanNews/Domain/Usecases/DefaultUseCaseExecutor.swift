//
//  DefaultUseCaseExecutor.swift
//  CleanNews
//
//  Created by Afees Lawal on 06.02.22.
//

import Foundation

struct DefaultUseCaseExecutor: UseCaseExecutor {
    public init() {}

    public func execute<U: UseCase, T>(_ useCase: U, completion: @escaping Completion<T>) where T == U.Response {
        useCase.execute { response in
            switch response {
            case let .success(object):
                completion(.success(object))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func execute<U: UseCase, P, T>(_ useCase: U, with params: P, completion: @escaping Completion<T>)
        where T == U.Response, P == U.Params
    {
        useCase.execute(with: params) { response in
            switch response {
            case let .success(object):
                completion(.success(object))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
