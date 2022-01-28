//
//  Request.swift
//  CleanNews
//
//  Created by Afees Lawal on 15.01.22.
//

import Foundation
import Moya

protocol Endpoint: TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: Moya.Method { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}
