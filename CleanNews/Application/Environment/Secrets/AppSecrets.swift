//
//  AppSecrets.swift
//  CleanNews
//
//  Created by Afees Lawal on 10.01.22.
//

import Foundation

protocol AppSecrets {
    func value(in environment: Environment) -> String
}
