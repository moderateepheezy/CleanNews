//
//  FeedSourceInformationView.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class FeedSourceInformationView: BaseView {
    // MARK: - Private

    private enum Constants {
        static let sourceAvatarSize: CGSize = .init(width: 18, height: 18)
        static let sourceAvatarRadius: CGFloat = sourceAvatarSize.height / 2
        static let categoryLabelHeight: CGFloat = 20
        static let categoryLabelRadius: CGFloat = 4
        static let categoryLabelVerticalPadding: CGFloat = 4
        static let categoryLabelHorizontalPadding: CGFloat = 8
        static let sourceNameLabelLeading: CGFloat = 4
    }

    private let sourceAvatarImageView = UIImageView.create {
        $0.backgroundColor = .secondaryBackgroundColor
        $0.contentMode = .scaleAspectFit
    }.applyCornerRadius(Constants.sourceAvatarRadius)

    private let sourceNameLabel = UILabel.create {
        $0.textColor = .primaryColor
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }

    private let categoryLabel = PaddingLabel.create {
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.insets = .sides(
            verticalInsets: Constants.categoryLabelVerticalPadding,
            horizontalInsets: Constants.categoryLabelHorizontalPadding
        )
        $0.clipsToBounds = true
    }.applyCornerRadius(Constants.categoryLabelRadius)

    // MARK: - Internal

    override func setupViewHeirachy() {
        addSubviews([sourceAvatarImageView, sourceNameLabel, categoryLabel])
    }

    override func setupConstraints() {
        sourceAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sourceAvatarImageView.constraintToConstant(Constants.sourceAvatarSize)

        sourceNameLabel.leadingAnchor.constraint(
            equalTo: sourceAvatarImageView.trailingAnchor,
            constant: Constants.sourceNameLabelLeading
        ).isActive = true

        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        [sourceAvatarImageView, sourceNameLabel, categoryLabel].forEach {
            $0.constraintCenterToSuperview(axis: [.vertical])
        }
    }

    override func setupProperties() {
        backgroundColor = .clear
        heightAnchor.constraint(equalToConstant: 19).isActive = true
    }

    func setupWith(imageURL: String, sourceName: String, category: String, categoryColor: UIColor) {
        print(imageURL)
        sourceNameLabel.text = sourceName
        categoryLabel.text = category
        categoryLabel.textColor = categoryColor
        categoryLabel.backgroundColor = categoryColor.withAlphaComponent(0.08)
    }
}
