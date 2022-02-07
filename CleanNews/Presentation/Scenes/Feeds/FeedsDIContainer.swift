//
//  FeedsDIContainer.swift
//  CleanNews
//
//  Created by Afees Lawal on 19.01.22.
//

import Foundation
import UIKit

final class FeedsDIContainer {
    private let networkService: NetworkService
    private let appConfiguration: AppConfiguration
    private let useCaseExecutor: UseCaseExecutor

    init(networkService: NetworkService, appConfiguration: AppConfiguration, useCaseExecutor: UseCaseExecutor) {
        self.networkService = networkService
        self.appConfiguration = appConfiguration
        self.useCaseExecutor = useCaseExecutor
    }

    func makeHomeRoutes() -> HomeRoutes {
        DefaultHomeRoutesFactory().make(
            apiKey: appConfiguration.apiKey,
            networkService: networkService,
            executor: useCaseExecutor
        )
    }

    func makeFeedsCoordinator(navigationController: UINavigationController) -> FeedsCoordinator {
        FeedsCoordinator(navigationController: navigationController, container: self)
    }
}

protocol HomeRoutesFactory {
    func make(
        apiKey: String,
        networkService: NetworkService,
        executor: UseCaseExecutor
    ) -> HomeRoutes
}

final class DefaultHomeRoutesFactory: HomeRoutesFactory {
    func make(
        apiKey: String,
        networkService: NetworkService,
        executor: UseCaseExecutor
    ) -> HomeRoutes {
        let viewModel = HomeViewModel(
            newsListUseCase: makeNewsListUseCase(apiKey: apiKey, networkService: networkService),
            executor: executor
        )

        return HomeViewController(view: HomeView(), viewModel: viewModel)
    }

    private func makeNewsListUseCase(
        apiKey: String,
        networkService: NetworkService
    ) -> NewsListUseCase {
        NewsListUseCase(
            newsRepository: DefaultNewsRepository(
                networkService: networkService,
                apiKey: apiKey
            )
        )
    }
}
