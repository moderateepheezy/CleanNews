//
//  UIScrollView+Extension.swift
//  CleanNews
//
//  Created by Afees Lawal on 08.01.22.
//

import UIKit

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
