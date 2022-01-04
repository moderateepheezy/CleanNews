//
//  CategoriesViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 04/01/2022.
//

import UIKit

final class CategoriesViewController: BaseViewController<CategoriesView> {
    // MARK: - Internal

    enum CategoriesSection: CaseIterable {
        case categories
    }

    enum CategoriesItem: Hashable {
        case category(String)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.delegate = self
        setupNavigationItem()
        makeDiffableDataSource()
    }

    override func addViewControllerBehaviors() {
        addBehaviors([
            NavigationBarStyleBehavior(barStyle: .light),
            NavigationBarTintColorBehaviour(tintColor: .skyWhite),
            NavigationBarWithTransparentBehaviour(),
            NavigationBarWithLineBehaviour(),
        ])
    }

    // MARK: - Private

    private(set) var dataSource: UICollectionViewDiffableDataSource<CategoriesSection, CategoriesItem>!

    private func makeDiffableDataSource() {
        let dataSource = UICollectionViewDiffableDataSource<CategoriesSection, CategoriesItem>(
            collectionView: customView.collectionView
        ) { (collectionView: UICollectionView, indexPath: IndexPath, item: CategoriesItem) -> UICollectionViewCell? in
            switch item {
            case let .category(category):
                let cell = collectionView.dequeueCell(ofType: CategoryCell.self, for: indexPath)
                cell.setupWith(title: category, color: .random())
                return cell
            }
        }

        self.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<CategoriesSection, CategoriesItem>()

        snapshot.appendSections([.categories])
        snapshot.appendItems(Array(1 ... 10).map { CategoriesItem.category("Business \($0)") }, toSection: .categories)

        dataSource.apply(snapshot)
    }

    private func setupNavigationItem() {
        title = "Categories"

        let bookmarkBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bookmark-white"),
            style: .done, target: self,
            action: #selector(showBookmarksTapped)
        )
        bookmarkBarButtonItem.tintColor = .skyWhite

        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search-white"), style: .done, target: self, action: #selector(searchTapped))
        searchBarButtonItem.tintColor = .skyWhite

        navigationItem.rightBarButtonItems = [searchBarButtonItem, bookmarkBarButtonItem]
    }

    @objc private func showBookmarksTapped() {}

    @objc private func searchTapped() {}
}

// MARK: - UICollectionViewDelegate

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.description)
        print(indexPath.item)
    }
}
