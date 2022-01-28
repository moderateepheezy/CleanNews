//
//  FeedsCell.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class FeedsCell: CollectionViewCell {
    // MARK: - Private

    private enum Constants {
        static let containerRadius: CGFloat = 8
        static let feedImageRegularHeight: CGFloat = 160
        static let feedImageMediumHeight: CGFloat = 200
        static let feedImageCornerRadius: CGFloat = 8
        static let captionLabelTopInset: CGFloat = 8
        static let spacing: CGFloat = 16
    }

    private var feedImageHeightConstraint: NSLayoutConstraint!

    private let containerView = UIView.create {
        $0.backgroundColor = .skyWhite
        $0.clipsToBounds = true
    }.applyCornerRadius(Constants.containerRadius)

    private let feedSourceInformationView = FeedSourceInformationView().layoutable()

    private let feedImageView = UIImageView.create {
        $0.backgroundColor = .secondaryBackgroundColor
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }.applyCornerRadius(Constants.feedImageCornerRadius)

    private let feedTitleLabel = UILabel.create {
        $0.textColor = .primaryColor
        $0.numberOfLines = 2
    }

    private let captionLabel = UILabel.create {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = .primaryColor
        $0.numberOfLines = 2
    }

    private let feedInteractiveView = FeedInteractiveView().layoutable()

    private func setSize(_ size: Size) {
        switch size {
        case .regular:
            feedTitleLabel.font = .systemFont(ofSize: 18)
            feedImageHeightConstraint.constant = Constants.feedImageRegularHeight
        case .medium:
            feedTitleLabel.font = .systemFont(ofSize: 20)
            feedImageHeightConstraint.constant = Constants.feedImageMediumHeight
        }
    }

    // MARK: - Internal

    enum Size {
        case regular
        case medium
    }

    override func setupViewHeirachy() {
        addSubview(containerView)
        containerView.addSubviews([feedSourceInformationView, feedImageView, feedTitleLabel, captionLabel, feedInteractiveView])
    }

    override func setupConstraints() {
        containerView.constraintToSuperviewEdges()

        feedSourceInformationView.constraintToEdges(of: containerView, excludingAnchors: [.bottom], withInsets: .allSides(Constants.spacing))

        feedImageView.constraintToEdges(of: containerView, excludingAnchors: [.top, .bottom], withInsets: .allSides(Constants.spacing))
        feedImageView.topAnchor.constraint(equalTo: feedSourceInformationView.bottomAnchor, constant: Constants.spacing).isActive = true
        feedImageHeightConstraint = feedImageView.heightAnchor.constraint(equalToConstant: Constants.feedImageRegularHeight)
        feedImageHeightConstraint.isActive = true

        feedTitleLabel.constraintToEdges(of: containerView, excludingAnchors: [.top, .bottom], withInsets: .allSides(Constants.spacing))
        feedTitleLabel.topAnchor.constraint(equalTo: feedImageView.bottomAnchor, constant: Constants.spacing).isActive = true

        captionLabel.constraintToEdges(of: containerView, excludingAnchors: [.top, .bottom], withInsets: .allSides(Constants.spacing))
        captionLabel.topAnchor.constraint(equalTo: feedTitleLabel.bottomAnchor, constant: Constants.captionLabelTopInset).isActive = true

        feedInteractiveView.constraintToEdges(of: containerView, excludingAnchors: [.top], withInsets: .allSides(Constants.spacing))
    }

    override func setupProperties() {
        backgroundColor = .primaryBackgroundColor
    }

    func setupWith(size: FeedsCell.Size, feedsListItemViewModel: FeedsListItemViewModel) {
        setSize(size)
        feedTitleLabel.text = feedsListItemViewModel.newsTitle
        captionLabel.text = feedsListItemViewModel.content
        feedSourceInformationView.setupWith(feedsListItemViewModel: feedsListItemViewModel)
        feedInteractiveView.setupWith(time: feedsListItemViewModel.dateTime)
        feedImageView.load(url: feedsListItemViewModel.newsImageURL)
    }
}
