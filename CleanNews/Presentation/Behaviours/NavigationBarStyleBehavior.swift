//
//  NavigationBarStyleBehavior.swift
//  CleanNews
//
//  Created by Afees Lawal on 01/01/2022.
//

import UIKit

struct NavigationBarStyleBehavior: ViewControllerLifecycleBehavior {
    enum BarStyle {
        case light
        case dark
    }

    let barStyle: BarStyle

    func viewDidLoad(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = barStyle == .dark ? .default : .black
    }

    func viewWillAppear(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = barStyle == .dark ? .default : .black
    }
}
