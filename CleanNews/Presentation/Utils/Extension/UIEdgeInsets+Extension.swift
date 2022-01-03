//
//  UIEdgeInsets+Extension.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

extension UIEdgeInsets {
    static func allSides(_ offset: CGFloat) -> UIEdgeInsets {
        .init(top: offset, left: offset, bottom: offset, right: offset)
    }
}
