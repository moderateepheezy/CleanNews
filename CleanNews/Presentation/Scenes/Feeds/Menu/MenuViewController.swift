//
//  MenuViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

final class MenuViewController: BaseViewController<MenuView> {
    // MARK: - Internal

    override func addViewControllerBehaviors() {
        addBehaviors([NavigationBarStyleBehavior(barStyle: .light), NavigationBarWithTransparentBehaviour()])
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        setupNavigationItem()
        makeDiffableDataSource()
    }

    // MARK: - Private

    private var dataSource: UICollectionViewDiffableDataSource<MenuSection, MenuItem>!

    private enum MainMenu: String, CaseIterable {
        case home = "Home"
        case categories = "Categories"
        case history = "History"
        case bookmarks = "Bookmarks"
        case subscription = "Subscription"
        case help = "Get Help"
    }

    private enum OtherMenu: String, CaseIterable {
        case settings = "Settings"
        case signout = "Signout"
    }

    private enum MenuSection: CaseIterable {
        case mainMenus
        case divider
        case otherMenus
    }

    private enum MenuItem: Hashable {
        case mainMenu(MainMenu)
        case divider
        case otherMenu(OtherMenu)
    }

    private func makeDiffableDataSource() {
        let dataSource = UICollectionViewDiffableDataSource<MenuSection, MenuItem>(
            collectionView: customView
        ) { (collectionView: UICollectionView, indexPath: IndexPath, item: MenuItem) -> UICollectionViewCell? in

            switch item {
            case let .mainMenu(menu):
                let cell = collectionView.dequeueCell(ofType: MenuCell.self, for: indexPath)
                cell.setupWith(title: menu.rawValue)
                return cell
            case let .otherMenu(menu):
                let cell = collectionView.dequeueCell(ofType: MenuCell.self, for: indexPath)
                cell.setupWith(title: menu.rawValue)
                return cell
            case .divider:
                return collectionView.dequeueCell(ofType: MenuDividerCell.self, for: indexPath)
            }
        }

        self.dataSource = dataSource

        var snapshot = NSDiffableDataSourceSnapshot<MenuSection, MenuItem>()
        snapshot.appendSections([.mainMenus])
        snapshot.appendItems(MainMenu.allCases.map { MenuItem.mainMenu($0) }, toSection: .mainMenus)

        snapshot.appendSections([.divider])
        snapshot.appendItems([.divider], toSection: .divider)

        snapshot.appendSections([.otherMenus])
        snapshot.appendItems(OtherMenu.allCases.map { MenuItem.otherMenu($0) }, toSection: .otherMenus)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func setupNavigationItem() {
        let closeBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "close"),
            style: .done, target: self,
            action: #selector(onCloseTapped)
        )

        closeBarButtonItem.tintColor = .skyWhite

        navigationItem.rightBarButtonItem = closeBarButtonItem
    }

    @objc private func onCloseTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
