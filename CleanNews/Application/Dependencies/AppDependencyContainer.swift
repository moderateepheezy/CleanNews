//
//  AppDependencyContainer.swift
//  CleanNews
//
//  Created by Afees Lawal on 09.01.22.
//

import Foundation

final class AppDependencyContainer {
    // MARK: - Private

    lazy var appConfiguration = AppConfiguration(environment: environment)

    // MARK: - Lifecycle

    init(environment: Environment) {
        self.environment = environment
    }

    // MARK: - Private

    private let environment: Environment
}
