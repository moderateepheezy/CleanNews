//
//  Environment.swift
//  CleanNews
//
//  Created by Afees Lawal on 09.01.22.
//

import Foundation

enum Environment {
    case labour
    case alpha

    init() {
        switch ConfigEnvironment(rawValue: getCurrentConfig()) {
        case .debugAlpha, .releaseAlpha:
            self = .alpha
        case .debugLabour, .releaseLabour:
            self = .labour
        default:
            fatalError("Must have a configuration scheme for Alpha or Labour")
        }
    }

    private enum ConfigEnvironment: String {
        case debugLabour = "Debug Labour"
        case releaseLabour = "Release Labour"

        case debugAlpha = "Debug Alpha"
        case releaseAlpha = "Release Alpha"
    }
}

private func getCurrentConfig() -> String {
    guard let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String
    else {
        fatalError("Cannot find Configuration")
    }
    return currentConfiguration
}
