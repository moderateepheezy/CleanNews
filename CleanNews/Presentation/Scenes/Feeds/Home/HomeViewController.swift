//
//  HomeViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    // MARK: - Internal

    enum HomeSection: CaseIterable {
        case topNews
        case latestNews
    }

    enum HomeItem: Hashable {
        case topNews(Int)
        case latestNews(Int)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.delegate = self
        setupNavigationItem()
        makeDiffableDataSource()
    }

    override func addViewControllerBehaviors() {
        addBehaviors([
            NavigationBarStyleBehavior(barStyle: .dark),
            NavigationBarTintColorBehaviour(tintColor: .primaryColor),
            NavigationBarWithTransparentBehaviour(),
            NavigationBarWithLineBehaviour(barStyle: .dark),
        ])
    }

    // MARK: - Private

    private(set) var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!

    private func makeDiffableDataSource() {
        let dataSource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(
            collectionView: customView.collectionView
        ) { (collectionView: UICollectionView, indexPath: IndexPath, item: HomeItem) -> UICollectionViewCell? in
            switch item {
            case .topNews:
                let cell = collectionView.dequeueCell(ofType: FeedsCell.self, for: indexPath)
                cell.setupWith(size: .medium)
                return cell
            case .latestNews:
                let cell = collectionView.dequeueCell(ofType: FeedsCell.self, for: indexPath)
                cell.setupWith(size: .regular)
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            if indexPath.section == 1 {
                return collectionView.dequeueReusableView(
                    ofType: LatestNewsSectionHeader.self,
                    forKind: UICollectionView.elementKindSectionHeader, for: indexPath
                )
            } else {
                return nil
            }
        }

        self.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()

        snapshot.appendSections([.topNews])
        snapshot.appendItems(Array(1 ... 5).map { HomeItem.topNews($0) }, toSection: .topNews)

        snapshot.appendSections([.latestNews])
        snapshot.appendItems(Array(1 ... 30).map { HomeItem.latestNews($0) }, toSection: .latestNews)

        dataSource.apply(snapshot)
    }

    private func setupNavigationItem() {
        title = "News Feed"

        let bookmarkBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bookmark"),
            style: .done, target: self,
            action: #selector(showBookmarksTapped)
        )
        bookmarkBarButtonItem.tintColor = .primaryColor

        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .done, target: self, action: #selector(searchTapped))
        searchBarButtonItem.tintColor = .primaryColor

        let menuButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(showMenuTapped))
        menuButtonItem.tintColor = .primaryColor

        navigationItem.rightBarButtonItems = [searchBarButtonItem, bookmarkBarButtonItem]
        navigationItem.leftBarButtonItem = menuButtonItem
    }

    @objc private func showMenuTapped() {
        let viewController = MenuViewController(view: MenuView())
        let navVc = UINavigationController(rootViewController: viewController)
        navVc.modalPresentationStyle = .fullScreen
        navVc.modalTransitionStyle = .flipHorizontal
        present(navVc, animated: true)
    }

    @objc private func showBookmarksTapped() {}

    @objc private func searchTapped() {}
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
