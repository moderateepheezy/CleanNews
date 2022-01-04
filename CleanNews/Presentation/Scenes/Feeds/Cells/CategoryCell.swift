//
//  CategoryCell.swift
//  CleanNews
//
//  Created by Afees Lawal on 04/01/2022.
//

import UIKit

final class CategoryCell: CollectionViewCell {
    // MARK: - Private

    private var categoryColor: UIColor? {
        didSet {
            categoryBarView.backgroundColor = categoryColor
        }
    }

    private enum Constants {
        static let categoryBarSize: CGSize = .init(width: 42, height: 4)
        static let categoryBarTopSpacing: CGFloat = 8
        static let categoryBarRadius: CGFloat = categoryBarSize.height / 2
        static let spacing: CGFloat = 24
        static let rightArrowSize: CGSize = .init(width: 18, height: 18)
    }

    private let categoryBarView = UIView.create {
        $0.constraintToConstant(Constants.categoryBarSize)
    }.withCornerRadius(Constants.categoryBarRadius)

    private let categoryTitleLabel = UILabel.create {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .skyWhite
    }

    private let rightArrowImageView = UIImageView.create {
        $0.image = UIImage(named: "arrow-right")
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Intenal

    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? categoryColor?.withAlphaComponent(0.16) : .clear
        }
    }

    override func setupViewHeirachy() {
        addSubviews([categoryBarView, categoryTitleLabel, rightArrowImageView])
    }

    override func setupConstraints() {
        categoryBarView.topAnchor.constraint(equalTo: categoryTitleLabel.topAnchor, constant: -Constants.categoryBarTopSpacing).isActive = true
        rightArrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing).isActive = true

        [categoryTitleLabel, categoryBarView].forEach {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing).isActive = true
        }
        [categoryTitleLabel, rightArrowImageView].forEach {
            $0.constraintCenterToSuperview(axis: [.vertical])
        }
    }

    override func setupProperties() {
        backgroundColor = .primaryColor
    }

    func setupWith(title: String, color: UIColor) {
        categoryTitleLabel.text = title
        categoryColor = color
    }
}
