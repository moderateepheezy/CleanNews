//
//  MenuView.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class MenuView: UICollectionView {
    // MARK: - LifeCycle

    init() {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .estimated(Constants.itemSizeEstimatedHeightDimension)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // the value for the groupSize doesn't matter
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .estimated(Constants.groupSizeEstimatedHeightDimension)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(Constants.sectionSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.sectionSpacing
        section.contentInsets = .init(
            top: Constants.sectionItemSpacing,
            leading: Constants.sectionItemSpacing,
            bottom: Constants.sectionItemSpacing,
            trailing: Constants.sectionItemSpacing
        )

        let layout = UICollectionViewCompositionalLayout(section: section)

        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private enum Constants {
        static let sectionSpacing: CGFloat = UIDevice.isSmallScreen ? 21 : 42
        static let sectionItemSpacing: CGFloat = 21
        static let sizeFractionalWidth: CGFloat = 1.0
        static let itemSizeEstimatedHeightDimension: CGFloat = 38
        static let groupSizeEstimatedHeightDimension: CGFloat = 38
        static let contentTopInset: CGFloat = 10
    }

    private func setup() {
        backgroundColor = .secondaryColor
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset.top = Constants.contentTopInset
        registerCell(ofType: MenuCell.self)
        registerCell(ofType: MenuDividerCell.self)
    }
}
