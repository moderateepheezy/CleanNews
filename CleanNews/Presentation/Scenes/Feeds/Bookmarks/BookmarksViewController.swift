//
//  BookmarksViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 08.01.22.
//

import UIKit

final class BookmarksViewController: BaseViewController<BookmarksView> {
    // MARK: - Internal

    enum BookmarksSection: CaseIterable {
        case bookmarks
    }

    enum BookmarksItem: Hashable {
        case bookmark(String)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.delegate = self
        setupNavigationItem()
        makeDiffableDataSource()

        let panGesture = UIPanGestureRecognizer()
        view.addGestureRecognizer(panGesture)
        panGesture.delegate = self
    }

    override func addViewControllerBehaviors() {
        addBehaviors([
            NavigationBarStyleBehavior(barStyle: .dark),
            NavigationBarTintColorBehaviour(tintColor: .primaryColor),
            NavigationBarWithTransparentBehaviour(),
            NavigationBarWithLineBehaviour(),
        ])
    }

    // MARK: - Private

    private(set) var dataSource: UICollectionViewDiffableDataSource<BookmarksSection, BookmarksItem>!

    private func makeDiffableDataSource() {
        let dataSource = UICollectionViewDiffableDataSource<BookmarksSection, BookmarksItem>(
            collectionView: customView.collectionView
        ) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            case let .bookmark(bookmark):
                let cell = collectionView.dequeueCell(ofType: BookmarkCell.self, for: indexPath)
                cell.setupWith(title: bookmark)
                return cell
            }
        }

        self.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<BookmarksSection, BookmarksItem>()

        snapshot.appendSections([.bookmarks])
        snapshot.appendItems(
            Array(1 ... 10)
                .map { BookmarksItem.bookmark("Plans to end Birmingham's 'car dominance' revealed\($0)") },
            toSection: .bookmarks
        )

        dataSource.apply(snapshot)
    }

    private func setupNavigationItem() {
        title = "Bookmarks"

        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search-white"), style: .done, target: self, action: #selector(searchTapped))
        searchBarButtonItem.tintColor = .primaryColor

        navigationItem.rightBarButtonItem = searchBarButtonItem
    }

    @objc private func searchTapped() {}
}

// MARK: - UICollectionViewDelegate

extension BookmarksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.description)
        print(indexPath.item)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension BookmarksViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        false
    }
}
