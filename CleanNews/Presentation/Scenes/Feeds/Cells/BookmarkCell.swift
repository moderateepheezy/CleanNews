//
//  BookmarkCell.swift
//  CleanNews
//
//  Created by Afees Lawal on 08.01.22.
//

import UIKit

final class BookmarkCell: CollectionViewCell {
    // MARK: - Private

    private enum Constants {
        static let containerRadius: CGFloat = 8
        static let feedImageWidth: CGFloat = 96
        static let space8: CGFloat = 8
        static let space16: CGFloat = 16
        static let deleteButtonWidth: CGFloat = 54
    }

    private let containerView = SwipeToRevealView(maxSwipe: Constants.deleteButtonWidth + 24).configure {
        $0.backgroundColor = .skyWhite
        $0.clipsToBounds = true
    }.applyCornerRadius(Constants.containerRadius)

    private let feedImageView = UIImageView.create {
        $0.backgroundColor = .secondaryBackgroundColor
        $0.clipsToBounds = true
        $0.widthAnchor.constraint(equalToConstant: Constants.feedImageWidth).isActive = true
    }.applyCornerRadius(Constants.containerRadius)

    private let feedTitleLabel = UILabel.create {
        $0.textColor = .primaryColor
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 14)
    }

    private let deleteButton = UIButton.create {
        $0.setImage(UIImage(named: "trash"), for: .normal)
        $0.backgroundColor = .deleteButtonBackgroundColor.withAlphaComponent(0.08)
        $0.widthAnchor.constraint(equalToConstant: Constants.deleteButtonWidth).isActive = true
    }.applyCornerRadius(Constants.containerRadius)

    private let feedSourceInformationView = FeedSourceInformationView().layoutable()

    private let feedInteractiveView = FeedInteractiveView().layoutable()

    // MARK: - Internal

    override func prepareForReuse() {
        contentView.frame = bounds
    }

    override func setupViewHeirachy() {
        addSubviews([deleteButton, containerView])
        containerView.addSubviews([feedImageView, feedSourceInformationView, feedTitleLabel, feedInteractiveView])
    }

    override func setupConstraints() {
        containerView.constraintToSuperviewEdges()
        deleteButton.constraintToLayoutGuide(of: self, excludingAnchors: [.left])
        feedImageView.constraintToEdges(of: containerView, excludingAnchors: [.right], withInsets: .allSides(8))

        feedSourceInformationView.constraintToEdges(
            of: containerView,
            excludingAnchors: [.left, .bottom],
            withInsets: .allSides(Constants.space8)
        )
        feedSourceInformationView.leadingAnchor.constraint(
            equalTo: feedImageView.trailingAnchor,
            constant: Constants.space16
        ).isActive = true

        feedTitleLabel.topAnchor.constraint(
            equalTo: feedSourceInformationView.bottomAnchor,
            constant: Constants.space8
        ).isActive = true
        feedTitleLabel.leadingAnchor.constraint(
            equalTo: feedImageView.trailingAnchor,
            constant: Constants.space16
        ).isActive = true
        feedTitleLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -Constants.space8
        ).isActive = true

        feedInteractiveView.constraintToEdges(
            of: containerView,
            excludingAnchors: [.left, .top],
            withInsets: .allSides(Constants.space8)
        )
        feedInteractiveView.leadingAnchor.constraint(
            equalTo: feedImageView.trailingAnchor,
            constant: Constants.space16
        ).isActive = true
    }

    override func setupProperties() {
        backgroundColor = .clear
    }

    func setupWith(title: String) {
        feedSourceInformationView.setupWith(imageURL: "", sourceName: "VNN News", category: "International", categoryColor: .random())
        feedTitleLabel.text = title
        feedInteractiveView.setupWith(time: "9 hrs ago", excludingActions: [.bookmark])
    }
}
