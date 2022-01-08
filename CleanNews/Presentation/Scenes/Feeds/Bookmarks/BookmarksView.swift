//
//  BookmarksView.swift
//  CleanNews
//
//  Created by Afees Lawal on 08.01.22.
//

import UIKit

final class BookmarksView: BaseView {
    // MARK: - Private

    private enum Constants {
        static let spacing: CGFloat = 24
        static let sectionItemSpacing: CGFloat = 12
        static let sizeFractionalWidth: CGFloat = 1.0
        static let itemSizeEstimatedHeightDimension: CGFloat = 130
        static let groupSizeEstimatedHeightDimension: CGFloat = 130
        static let clearAllButtonHeight: CGFloat = 45
        static let clearAllButtonRadius: CGFloat = 8
        static let collectionViewTopInset: CGFloat = 20
    }

    private let clearBookmarksButton = UIButton.create {
        $0.setTitle("Clear all", for: .normal)
        $0.setTitleColor(.primaryColor, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.heightAnchor.constraint(equalToConstant: Constants.clearAllButtonHeight).isActive = true
        $0.addTarget(self, action: #selector(tapClearAllBookmarksTapped), for: .touchUpInside)
    }.applyCornerRadius(Constants.clearAllButtonRadius, borderColor: .primaryColor, borderWidth: 1)

    private(set) lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCompositionLayout()).configure {
        $0.backgroundColor = .primaryBackgroundColor
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.registerCell(ofType: BookmarkCell.self)
    }

    @objc private func tapClearAllBookmarksTapped() {
        onTapClearAllBookmarks?()
    }

    // MARK: - Internal

    var onTapClearAllBookmarks: (() -> Void)?

    override func setupViewHeirachy() {
        addSubviews([collectionView, clearBookmarksButton])
    }

    override func setupConstraints() {
        collectionView.constraintToLayoutGuide(
            of: self,
            excludingAnchors: [.bottom],
            withInsets: .init(top: Constants.collectionViewTopInset, left: 0, bottom: 0, right: 0)
        )
        collectionView.bottomAnchor.constraint(equalTo: clearBookmarksButton.topAnchor, constant: -Constants.spacing).isActive = true

        clearBookmarksButton.constraintToLayoutGuide(
            of: self,
            excludingAnchors: [.top],
            withInsets: .allSides(Constants.spacing)
        )
    }

    override func setupProperties() {
        backgroundColor = .primaryBackgroundColor
    }
}

// MARK: - UICollectionViewLayout

private extension BookmarksView {
    func makeCompositionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .absolute(Constants.itemSizeEstimatedHeightDimension)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: Constants.sectionItemSpacing,
            leading: Constants.sectionItemSpacing,
            bottom: Constants.sectionItemSpacing,
            trailing: Constants.sectionItemSpacing
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .absolute(Constants.groupSizeEstimatedHeightDimension)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(Constants.sectionItemSpacing)

        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
