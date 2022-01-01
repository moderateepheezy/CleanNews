//
//  Creatable.swift
//  CleanNews
//
//  Created by Afees Lawal on 01/01/2022.
//

import UIKit

protocol Creatable: UIView { init() }

extension Creatable {
    static func create(createOn: (Self) -> Void) -> Self {
        let view = Self(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        createOn(view)
        return view
    }

    func configure(handler: (Self) -> Void) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        handler(self)
        return self
    }
}

extension UIView: Creatable {}
