//
//  MenuDividerCell.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class MenuDividerCell: CollectionViewCell {
    // MARK: Private

    private enum Constants {
        static let backgroundColorAlpha: CGFloat = 0.24
        static let dividerHeight: CGFloat = 1.0
        static let dividerSpacing: CGFloat = 24
    }

    private lazy var dividerView = UIView.create {
        $0.backgroundColor = .skyWhite.withAlphaComponent(Constants.backgroundColorAlpha)
    }

    // MARK: - Internal

    override func setupViewHeirachy() {
        addSubview(dividerView)
    }

    override func setupConstraints() {
        dividerView.constraintToSuperviewEdges(excludingAnchors: [.top, .bottom], withInsets: .allSides(Constants.dividerSpacing))
        dividerView.constraintCenterToSuperview()
        dividerView.heightAnchor.constraint(equalToConstant: Constants.dividerHeight).isActive = true
    }

    override func setupProperties() {
        backgroundColor = .clear
    }
}
