//
//  AppAppearance.swift
//  CleanNews
//
//  Created by Afees Lawal on 01/01/2022.
//

import UIKit

enum AppAppearance {
    static func applyStyles() {
        UINavigationBar.appearance().barTintColor = .skyWhite
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.primaryBackgroundColor,
            .font: UIFont.systemFont(ofSize: 21, weight: .bold),
        ]

        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.clear]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
    }
}
