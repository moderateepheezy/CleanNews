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

    init(networkService: NetworkService, appConfiguration: AppConfiguration) {
        self.networkService = networkService
        self.appConfiguration = appConfiguration
    }

    func makeHomeViewController() -> UIViewController {
        HomeViewController(
            view: HomeView(),
            viewModel: HomeViewModel(
                newsListUseCase: DefaultNewsListUseCase(
                    newsRepository: DefaultNewsRepository(
                        networkService: networkService,
                        apiKey: appConfiguration.apiKey
                    )
                )
            )
        )
    }

    func makeFeedsCoordinator(navigationController: UINavigationController) -> FeedsCoordinator {
        FeedsCoordinator(navigationController: navigationController, container: self)
    }
}
