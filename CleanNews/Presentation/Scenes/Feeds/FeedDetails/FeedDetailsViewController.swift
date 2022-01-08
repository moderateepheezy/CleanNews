//
//  FeedDetailsViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 06.01.22.
//

import UIKit

final class FeedDetailsViewController: BaseViewController<FeedDetailsView> {
    // MARK: - Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        customView.setupWith()
    }

    override func addViewControllerBehaviors() {
        addBehaviors([
            NavigationBarStyleBehavior(barStyle: .dark),
            NavigationBarTintColorBehaviour(tintColor: .primaryColor),
            NavigationBarWithTransparentBehaviour(),
        ])
    }

    private func setupNavigationItem() {
        let bookmarkBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bookmark"),
            style: .done, target: self,
            action: #selector(showBookmarksTapped)
        )
        bookmarkBarButtonItem.tintColor = .primaryColor

        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .done, target: self, action: #selector(searchTapped))
        searchBarButtonItem.tintColor = .primaryColor

        navigationItem.rightBarButtonItems = [searchBarButtonItem, bookmarkBarButtonItem]
    }

    @objc private func showBookmarksTapped() {}

    @objc private func searchTapped() {}
}
