//
//  AppConfiguration.swift
//  CleanNews
//
//  Created by Afees Lawal on 10.01.22.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = CleanNewsSecrets.apiKey.value(in: environment)

    private let environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }
}
