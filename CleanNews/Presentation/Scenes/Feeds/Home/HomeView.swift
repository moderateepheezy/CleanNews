//
//  HomeView.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class HomeView: BaseView {
    // MARK: - Private

    private enum Constants {
        static let collectionViewTopSpacing: CGFloat = 30
        static let sizeFractionalWidth: CGFloat = 1
        static let topNewsSizeFractionalWidth: CGFloat = 0.8
        static let topNewsEstimatedHeight: CGFloat = 400
        static let latestNewsEstimatedHeight: CGFloat = 380
        static let latestNewsHeaderHeight: CGFloat = 33
        static let itemSpacing: CGFloat = 8
        static let sectionVerticalSpacing: CGFloat = 24
        static let topNewsItemTrailingSpacing: CGFloat = 16
    }

    private(set) lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCompositionLayout()).configure {
        $0.backgroundColor = .primaryBackgroundColor
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.registerCell(ofType: FeedsCell.self)
        $0.registerReusableView(ofType: LatestNewsSectionHeader.self, forKind: UICollectionView.elementKindSectionHeader)
    }

    private func makeCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            switch HomeViewController.HomeSection.allCases[sectionIndex] {
            case .topNews: return self?.makeTopNewsLayout()
            case .latestNews: return self?.makeLatestNewsLayout()
            }
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration

        return layout
    }

    private func makeTopNewsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .estimated(Constants.topNewsEstimatedHeight)
        )

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: Constants.topNewsItemTrailingSpacing
        )

        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.topNewsSizeFractionalWidth),
            heightDimension: .estimated(Constants.topNewsEstimatedHeight)
        )

        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

        return layoutSection
    }

    private func makeLatestNewsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .absolute(Constants.latestNewsEstimatedHeight)
        )

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.itemSpacing,
            leading: 0,
            bottom: Constants.itemSpacing,
            trailing: 0
        )

        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .estimated(Constants.latestNewsEstimatedHeight)
        )

        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.interItemSpacing = .fixed(Constants.itemSpacing)

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(
            top: Constants.itemSpacing,
            leading: Constants.sectionVerticalSpacing,
            bottom: 0,
            trailing: Constants.sectionVerticalSpacing
        )

        let header = createLatestNewsSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]

        return layoutSection
    }

    private func createLatestNewsSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.sizeFractionalWidth),
            heightDimension: .estimated(Constants.latestNewsHeaderHeight)
        )

        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    // MARK: - Internal

    override func setupViewHeirachy() {
        addSubview(collectionView)
    }

    override func setupConstraints() {
        collectionView.constraintToLayoutGuide(
            of: self,
            withInsets: .init(
                top: Constants.collectionViewTopSpacing,
                left: 0,
                bottom: 0,
                right: 0
            )
        )
    }

    override func setupProperties() {
        backgroundColor = .primaryBackgroundColor
    }
}
