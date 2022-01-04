//
//  NavigationBarWithLineBehaviour.swift
//  CleanNews
//
//  Created by Afees Lawal on 04/01/2022.
//

import UIKit

struct NavigationBarWithLineBehaviour: ViewControllerLifecycleBehavior {
    func viewDidLoad(viewController: UIViewController) {
        let lineView = UIView().layoutable()
        viewController.view.addSubview(lineView)

        lineView.backgroundColor = .lightNavBarDivider.withAlphaComponent(0.4)
        lineView.constraintToEdges(
            of: viewController.view,
            excludingAnchors: [.bottom, .top],
            withInsets: .sides(verticalInsets: 24, horizontalInsets: 24)
        )
        lineView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
