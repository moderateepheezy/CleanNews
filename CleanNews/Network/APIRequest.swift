//
//  APIRequest.swift
//  CleanNews
//
//  Created by Afees Lawal on 16.01.22.
//

import Foundation
import Moya

enum APIRequest {
    case request(RequestConfig)
}

extension APIRequest: Endpoint {
    var baseURL: URL {
        URL(string: "https://newsapi.ai/api/v1")!
    }

    var path: String {
        switch self {
        case let .request(config):
            return config.path
        }
    }

    var method: Moya.Method {
        .post
    }

    var task: Task {
        switch self {
        case let .request(requestConfig):
            return .requestParameters(parameters: requestConfig.params, encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? { nil }
}
