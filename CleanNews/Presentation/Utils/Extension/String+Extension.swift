//
//  String+Extension.swift
//  CleanNews
//
//  Created by Afees Lawal on 24.01.22.
//

import Foundation

extension StringProtocol {
    var capitalizeFirstLetter: String {
        prefix(1).capitalized + lowercased().dropFirst()
    }

    var uppercasedFirstLetter: String {
        prefix(1).uppercased() + lowercased().dropFirst()
    }
}
