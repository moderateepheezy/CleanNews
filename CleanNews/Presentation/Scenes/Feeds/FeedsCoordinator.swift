//
//  FeedsCoordinator.swift
//  CleanNews
//
//  Created by Afees Lawal on 17.01.22.
//

import Foundation
import UIKit

final class FeedsCoordinator {
    private weak var navigationController: UINavigationController?
    private let container: FeedsDIContainer

    init(navigationController: UINavigationController, container: FeedsDIContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let homeRoutes = container.makeHomeRoutes()
        homeRoutes.onBackPressed = {}
        navigationController?.pushViewController(homeRoutes.viewController, animated: false)
    }
}

extension FeedsCoordinator: HomeViewControllerDelegate {}
