//
//  NavigationBarTintColorBehaviour.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

struct NavigationBarTintColorBehaviour: ViewControllerLifecycleBehavior {
    let tintColor: UIColor

    func viewDidLoad(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
        viewController.navigationController?.navigationBar.barTintColor = tintColor
    }
}
