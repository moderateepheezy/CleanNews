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
    static let contentTextColor = UIColor(named: "contentTextColor") ?? .lightGray

    // Category
    static let business = UIColor(named: "business") ?? .green
}

extension UIColor {
    static func random() -> UIColor {
        UIColor(
            red: .random(),
            green: .random(),
            blue: .random(),
            alpha: 1.0
        )
    }
}

private extension CGFloat {
    static func random() -> CGFloat {
        CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
