//
//  LatestNewsSectionHeader.swift
//  CleanNews
//
//  Created by Afees Lawal on 04/01/2022.
//

import UIKit

final class LatestNewsSectionHeader: UICollectionReusableView {
    // MARK: Private

    private let titleLabel = UILabel.create {
        $0.text = "Latest News"
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .primaryColor
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    private func setup() {
        setupViewHeirachy()
        setupConstraints()
        setupProperties()
    }

    func setupViewHeirachy() {
        addSubview(titleLabel)
    }

    func setupConstraints() {
        titleLabel.constraintToSuperviewEdges()
    }

    func setupProperties() {
        backgroundColor = .clear
    }
}
