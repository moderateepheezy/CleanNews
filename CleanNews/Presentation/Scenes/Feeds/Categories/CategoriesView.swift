//
//  CategoriesView.swift
//  CleanNews
//
//  Created by Afees Lawal on 04/01/2022.
//

import UIKit

final class CategoriesView: BaseView {
    // MARK: - Private

    private enum Constants {
        static let sectionItemSpacing: CGFloat = 22
        static let sizeFractionalWidth: CGFloat = 1.0
        static let itemSizeEstimatedHeightDimension: CGFloat = 70
        static let groupSizeEstimatedHeightDimension: CGFloat = 70
        static let contentTopInset: CGFloat = 10
        static let collectionViewTopInset: CGFloat = 20
    }

    private(set) lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCompositionLayout()).configure {
        $0.backgroundColor = .primaryColor
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.registerCell(ofType: CategoryCell.self)
        $0.registerReusableView(ofType: LatestNewsSectionHeader.self, forKind: UICollectionView.elementKindSectionHeader)
    }

    private func makeCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
                heightDimension: .estimated(Constants.itemSizeEstimatedHeightDimension)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
                heightDimension: .absolute(Constants.groupSizeEstimatedHeightDimension)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(Constants.sectionItemSpacing)

            let section = NSCollectionLayoutSection(group: group)

            return section
        }

        return layout
    }

    // MARK: - Internal

    override func setupViewHeirachy() {
        addSubview(collectionView)
    }

    override func setupConstraints() {
        collectionView.constraintToLayoutGuide(
            of: self,
            withInsets: .init(
                top: Constants.collectionViewTopInset,
                left: 0,
                bottom: 0,
                right: 0
            )
        )
    }

    override func setupProperties() {
        backgroundColor = .primaryColor
    }
}
