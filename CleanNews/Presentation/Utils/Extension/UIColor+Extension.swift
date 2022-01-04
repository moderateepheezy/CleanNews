//
//  UIColor+Extension.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

extension UIColor {
    static let skyWhite = UIColor(named: "skyWhite") ?? .white
    static let primaryColor = UIColor(named: "primaryColor") ?? .black
    static let darkNavBarDivider = UIColor(named: "darkNavBarDivider") ?? .lightGray
    static let lightNavBarDivider = UIColor(named: "lightNavBarDivider") ?? .darkGray
    static let primaryBackgroundColor = UIColor(named: "backgroundColor") ?? .lightGray.withAlphaComponent(0.5)
    static let secondaryBackgroundColor = UIColor(named: "secondaryBackgroundColor") ?? .darkGray

    // Category
    static let business = UIColor(named: "business") ?? .green
}
