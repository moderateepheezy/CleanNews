//
//  CollectionViewCell.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    // MARK: - LifeCylce

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Internal

    func setupViewHeirachy() { abstractMethod() }

    @objc func setupConstraints() { abstractMethod() }

    func setupProperties() {}

    // MARK: - Private

    private func setupView() {
        backgroundColor = .skyWhite
        setupViewHeirachy()
        setupConstraints()
        setupProperties()
    }
}
