//
//  AppDependencyContainer.swift
//  CleanNews
//
//  Created by Afees Lawal on 09.01.22.
//

import Foundation

final class AppDependencyContainer {
    // MARK: - Lifecycle

    init(environment: Environment) {
        self.environment = environment
    }

    // MARK: - Internal

    func makeFeedsDIContainer() -> FeedsDIContainer {
        FeedsDIContainer(networkService: nerworkService, appConfiguration: appConfiguration)
    }

    // MARK: - Private

    private lazy var appConfiguration = AppConfiguration(environment: environment)
    private lazy var nerworkService: NetworkService = CleanNetworkService(apiKey: appConfiguration.apiKey)
    private let environment: Environment
}
