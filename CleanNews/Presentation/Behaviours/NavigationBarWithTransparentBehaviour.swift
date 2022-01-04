//
//  NavigationBarWithTransparentBehaviour.swift
//  CleanNews
//
//  Created by Afees Lawal on 04/01/2022.
//

import UIKit

struct NavigationBarWithTransparentBehaviour: ViewControllerLifecycleBehavior {
    func viewWillAppear(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
        viewController.navigationController?.navigationBar.isTranslucent = true
    }

    func viewWillDisappear(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
        viewController.navigationController?.navigationBar.isTranslucent = false
    }
}
