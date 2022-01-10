//
//  CleanNewsSecrets.swift
//  CleanNews
//
//  Created by Afees Lawal on 10.01.22.
//

import Foundation

enum CleanNewsSecrets: AppSecrets {
    case apiKey

    // MARK: - Internal

    func value(in environment: Environment) -> String {
        switch environment {
        case .labour:
            return value(for: AppDevSecrets.self)
        case .alpha:
            return value(for: AppProdSecrets.self)
        }
    }

    // MARK: Private

    private func value<S: Secrets>(for _: S.Type) -> String {
        switch self {
        case .apiKey:
            return S.apiKey
        }
    }
}
