//
//  UIImageView+Extension.swift
//  CleanNews
//
//  Created by Afees Lawal on 28.01.22.
//

import Kingfisher
import UIKit

extension UIImageView {
    func load(url: URL?) {
        DispatchQueue.main.async {
            self.kf.setImage(with: url, options: [.transition(.fade(0.25))])
        }
    }
}
