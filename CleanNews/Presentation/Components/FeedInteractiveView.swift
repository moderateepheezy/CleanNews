//
//  FeedInteractiveView.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class FeedInteractiveView: BaseView {
    // MARK: - Private

    private enum Constants {
        static let clockSize: CGSize = .init(width: 13, height: 13)
        static let timeStackViewSpacing: CGFloat = 4
        static let actionStackViewSpacing: CGFloat = 8
    }

    private let clockImageView = UIImageView.create {
        $0.image = UIImage(named: "time")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.constraintToConstant(Constants.clockSize)
    }

    private let timeLabel = UILabel.create {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .secondaryBackgroundColor
    }

    private lazy var commentButton = UIButton.create {
        $0.setImage(UIImage(named: "comment"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }

    private lazy var shareButton = UIButton.create {
        $0.setImage(UIImage(named: "share"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }

    private lazy var bookmarkButton = UIButton.create {
        $0.setImage(UIImage(named: "bookmark"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
    }

    private lazy var timeStackView = UIStackView(arrangedSubviews: [clockImageView, timeLabel]).configure {
        $0.spacing = Constants.timeStackViewSpacing
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillProportionally
    }

    private lazy var actionStackView = UIStackView(arrangedSubviews: [commentButton, shareButton, bookmarkButton]).configure {
        $0.spacing = Constants.actionStackViewSpacing
        $0.axis = .horizontal
        $0.alignment = .trailing
        $0.distribution = .fillProportionally
    }

    @objc private func commentButtonTapped() {
        sendAction?(.comment)
    }

    @objc private func shareButtonTapped() {
        sendAction?(.share)
    }

    @objc private func bookmarkButtonTapped() {
        sendAction?(.bookmark)
    }

    // MARK: - Internal

    enum Action {
        case comment
        case share
        case bookmark
    }

    var sendAction: ((Action) -> Void)?

    override func setupViewHeirachy() {
        addSubviews([timeStackView, actionStackView])
    }

    override func setupConstraints() {
        timeStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        timeStackView.constraintCenterToSuperview(axis: [.vertical])
        actionStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        actionStackView.constraintCenterToSuperview(axis: [.vertical])
    }

    override func setupProperties() {
        backgroundColor = .clear
        heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    func setupWith(time: String, excludingActions: [Action] = []) {
        timeLabel.text = time
        bookmarkButton.isHidden = excludingActions.contains(.bookmark)
        shareButton.isHidden = excludingActions.contains(.share)
        commentButton.isHidden = excludingActions.contains(.comment)
    }
}
