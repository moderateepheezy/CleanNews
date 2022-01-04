//
//  NavigationBarStyleBehavior.swift
//  CleanNews
//
//  Created by Afees Lawal on 01/01/2022.
//

import UIKit

struct NavigationBarStyleBehavior: ViewControllerLifecycleBehavior {
    let barStyle: NavigationBarStyle

    func viewDidLoad(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = barStyle == .dark ? .default : .black
        viewController.navigationController?.navigationBar.barTintColor = .primaryBackgroundColor
    }

    func viewWillAppear(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = barStyle == .dark ? .default : .black
        viewController.navigationController?.navigationBar.barTintColor = barStyle == .light ? .primaryBackgroundColor : .primaryColor
        viewController.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: barStyle == .light ? UIColor.primaryBackgroundColor : UIColor.primaryColor,
            .font: UIFont.monospacedSystemFont(ofSize: 21, weight: .semibold),
        ]
    }
}
