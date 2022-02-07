//
//  ViewControllerRoutes.swift
//  CleanNews
//
//  Created by Afees Lawal on 06.02.22.
//

import UIKit

protocol ViewControllerRoutes: AnyObject {
    var viewController: UIViewController { get }
}

extension ViewControllerRoutes where Self: UIViewController {
    var viewController: UIViewController {
        self
    }
}
