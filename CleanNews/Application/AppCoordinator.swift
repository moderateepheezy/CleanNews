//
//  AppCoordinator.swift
//  CleanNews
//
//  Created by Afees Lawal on 16.01.22.
//

import Foundation
import UIKit

final class AppCoordinator {
    var navigationController: UINavigationController
    private let container: AppDependencyContainer

    init(navigationController: UINavigationController, container: AppDependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let feedsContainer = container.makeFeedsDIContainer()
        let feedsCoordinator = feedsContainer.makeFeedsCoordinator(navigationController: navigationController)
        feedsCoordinator.start()
    }
}
