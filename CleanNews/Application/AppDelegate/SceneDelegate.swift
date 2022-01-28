//
//  SceneDelegate.swift
//  CleanNews
//
//  Created by Afees Lawal on 31/12/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let container = AppDependencyContainer(environment: Environment())
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        AppAppearance.applyStyles()

        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator = AppCoordinator(navigationController: navigationController, container: container)
        appCoordinator?.start()
    }
}
