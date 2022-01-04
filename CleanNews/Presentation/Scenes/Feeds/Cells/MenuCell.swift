//
//  MenuCell.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class MenuCell: CollectionViewCell {
    // MARK: Private

    private lazy var menuTitleLabel = UILabel.create {
        $0.textColor = .skyWhite
        $0.font = .systemFont(ofSize: 28)
        $0.textAlignment = .center
    }

    // MARK: - Internal

    override func setupViewHeirachy() {
        addSubview(menuTitleLabel)
    }

    override func setupConstraints() {
        menuTitleLabel.constraintCenterToSuperview()
    }

    override func setupProperties() {
        backgroundColor = .clear
    }

    func setupWith(title: String) {
        menuTitleLabel.text = title
    }
}
