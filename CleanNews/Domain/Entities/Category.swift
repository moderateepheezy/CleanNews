//
//  Category.swift
//  CleanNews
//
//  Created by Afees Lawal on 19.01.22.
//

import Foundation
import UIKit

enum Category: String, CaseIterable {
    case business
    case general
    case entertainment
    case health
    case science
    case sports
    case technology
    case education
    case fashion
    case food
    case religion
    case unknown

    init(rawCategory: String) {
        if let category = Category(rawValue: rawCategory.lowercased()) {
            self = category
        } else {
            self = .unknown
        }
    }

    var name: String {
        rawValue.capitalizeFirstLetter
    }

    var color: UIColor {
        switch self {
        case .business:
            return .business
        case .general:
            return .general
        case .entertainment:
            return .entertainment
        case .health:
            return .health
        case .science:
            return .science
        case .sports:
            return .sport
        case .technology:
            return .technology
        case .education:
            return .education
        case .fashion:
            return .fashion
        case .food:
            return .food
        case .religion:
            return .religion
        case .unknown:
            return .clear
        }
    }
}
