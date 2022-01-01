//
//  AppAppearance.swift
//  CleanNews
//
//  Created by Afees Lawal on 01/01/2022.
//

import UIKit

enum AppAppearance {
    static func applyStyles() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}
