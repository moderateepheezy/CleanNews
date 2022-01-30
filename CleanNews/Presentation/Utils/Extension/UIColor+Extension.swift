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
    static let deleteButtonBackgroundColor = UIColor(named: "deleteButtonBackgroundColor") ?? .systemPink

    // Categories
    static let business = UIColor(named: "business") ?? .green
    static let education = UIColor(named: "education") ?? .magenta
    static let entertainment = UIColor(named: "entertainment") ?? .blue.withAlphaComponent(0.5)
    static let fashion = UIColor(named: "fashion") ?? .magenta.withAlphaComponent(0.2)
    static let food = UIColor(named: "food") ?? .blue
    static let general = UIColor(named: "general") ?? .purple
    static let health = UIColor(named: "health") ?? .systemPink
    static let religion = UIColor(named: "religion") ?? .systemBlue.withAlphaComponent(0.8)
    static let science = UIColor(named: "science") ?? .yellow
    static let sport = UIColor(named: "sport") ?? .systemGreen
    static let technology = UIColor(named: "technology") ?? .darkGray
    static let politics = UIColor(named: "politics") ?? .cyan
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
