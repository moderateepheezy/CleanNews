//
//  FeedDetailsView.swift
//  CleanNews
//
//  Created by Afees Lawal on 07.01.22.
//

import UIKit

final class FeedDetailsView: BaseView {
    // MARK: - Private

    private enum Constants {
        static let scrollViewTopInset: CGFloat = 20
        static let categoryBarSize: CGSize = .init(width: 52, height: 4)
        static let categoryBarRadius: CGFloat = categoryBarSize.height / 2
        static let feedImageHeight: CGFloat = UIDevice.isSmallScreen ? 180 : 220
        static let feedImageCornerRadius: CGFloat = 8
        static let contentTextViewTopInset: CGFloat = 8
        static let spacing: CGFloat = 16
    }

    private let feedImageView = UIImageView.create {
        $0.backgroundColor = .secondaryBackgroundColor
        $0.clipsToBounds = true
        $0.heightAnchor.constraint(equalToConstant: Constants.feedImageHeight).isActive = true
    }.applyCornerRadius(Constants.feedImageCornerRadius)

    private let feedSourceInformationView = FeedSourceInformationView().layoutable()

    private let feedTitleLabel = UILabel.create {
        $0.textColor = .primaryColor
        $0.numberOfLines = 3
        $0.font = .systemFont(ofSize: 26)
    }

    private let feedInteractiveView = FeedInteractiveView().layoutable()

    private let categoryBarView = UIView.create {
        $0.constraintToConstant(Constants.categoryBarSize)
    }.applyCornerRadius(Constants.categoryBarRadius)

    private lazy var categoryBarStackView = UIStackView(arrangedSubviews: [categoryBarView, UIView()]).configure {
        $0.spacing = 16
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }

    private let contentTextView = UITextView.create {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .contentTextColor
        $0.textAlignment = .justified
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
    }

    private let scrollView = UIScrollView.create {
        $0.alwaysBounceHorizontal = true
        $0.alwaysBounceHorizontal = true
    }

    private lazy var topStackView = UIStackView(arrangedSubviews: [
        feedImageView,
        feedSourceInformationView,
        feedTitleLabel,
        feedInteractiveView,
    ]).configure {
        $0.spacing = 16
        $0.distribution = .fillProportionally
        $0.axis = .vertical
    }

    private lazy var contentStackView = UIStackView(arrangedSubviews: [categoryBarStackView, contentTextView])
        .configure {
            $0.spacing = 24
            $0.distribution = .equalSpacing
            $0.axis = .vertical
        }

    private lazy var mainStackView = UIStackView(arrangedSubviews: [topStackView, contentStackView])
        .configure {
            $0.spacing = 24
            $0.distribution = .equalSpacing
            $0.axis = .vertical
        }

    // MARK: - Internal

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        scrollView.updateContentView()
    }

    override func setupViewHeirachy() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
    }

    override func setupConstraints() {
        scrollView.constraintCenter(to: self, axis: [.horizontal])
        scrollView.constraintToLayoutGuide(
            of: self,
            withInsets: .init(
                top: Constants.scrollViewTopInset,
                left: 0,
                bottom: 0,
                right: 0
            )
        )

        mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainStackView.constraintToEdges(of: self, excludingAnchors: [.top], withInsets: .allSides(16))
    }

    override func setupProperties() {
        backgroundColor = .primaryBackgroundColor
    }

    func setupWith() {
        let categoryColor = UIColor.random()
        feedTitleLabel.text = "Maunt University Is Going Need-Blind In Admissions"
        feedSourceInformationView.setupWith(imageURL: "", sourceName: "VNN News", category: "Education", categoryColor: categoryColor)
        categoryBarView.backgroundColor = categoryColor
        contentTextView.text = Array(1 ... 20).map { _ in "Usam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea aki\n" }.joined()
        feedInteractiveView.setupWith(time: "4 hrs ago · 5 min read")
    }
}
