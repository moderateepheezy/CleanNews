//
//  HomeViewController.swift
//  CleanNews
//
//  Created by Afees Lawal on 03/01/2022.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {}

protocol HomeRoutes: ViewControllerRoutes {
    var onBackPressed: (() -> Void)? { get set }
    var homeViewControllerDelegate: HomeViewControllerDelegate? { get set }
}

final class HomeViewController: BaseViewController<HomeView>, HomeRoutes {
    // MARK: - Internal

    var onBackPressed: (() -> Void)?

    weak var homeViewControllerDelegate: HomeViewControllerDelegate?

    enum HomeSection: CaseIterable {
        case topNews
        case latestNews
    }

    enum HomeItem: Hashable {
        case topNews(FeedsListItemViewModel)
        case latestNews(FeedsListItemViewModel)
    }

    // MARK: - LifeCycle

    init(view: HomeView, viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(view: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.delegate = self
        setupNavigationItem()
        makeDiffableDataSource()
        viewModel.viewDidLoad()
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

    private var viewModel: HomeViewModelType
    private(set) var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!
    private var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
    private let refreshControl = UIRefreshControl()

    override func bindViews() {
        customView.collectionView.refreshControl = refreshControl
    }

    override func setupViewActions() {}

    override func bindViewModel() {
        viewModel.newsListItems.observe(on: self) { [weak self] items in
            guard let self = self, let items = items else { return }
            self.snapshot.appendSections([.latestNews])
            self.snapshot.appendItems(items.map { HomeItem.latestNews($0) }, toSection: .latestNews)
            self.dataSource.apply(self.snapshot)
        }
        viewModel.newsHeaderListItems.observe(on: self) { [weak self] items in
            guard let self = self, let items = items else { return }
            self.snapshot.appendSections([.topNews])
            self.snapshot.appendItems(items.map { HomeItem.topNews($0) }, toSection: .topNews)
            self.dataSource.apply(self.snapshot)
        }
        viewModel.loading.observe(on: self) { [weak self] state in
            switch state {
            case .fullScreen, .nextPage:
                self?.refreshControl.beginRefreshing()
            default:
                self?.refreshControl.endRefreshing()
            }
        }
    }

    private func makeDiffableDataSource() {
        let dataSource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(
            collectionView: customView.collectionView
        ) { (collectionView: UICollectionView, indexPath: IndexPath, item: HomeItem) -> UICollectionViewCell? in
            switch item {
            case let .topNews(item):
                let cell = collectionView.dequeueCell(ofType: FeedsCell.self, for: indexPath)
                cell.setupWith(size: .medium, feedsListItemViewModel: item)
                return cell
            case let .latestNews(item):
                let cell = collectionView.dequeueCell(ofType: FeedsCell.self, for: indexPath)
                cell.setupWith(size: .regular, feedsListItemViewModel: item)
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

    @objc private func showBookmarksTapped() {
        let viewController = BookmarksViewController(view: BookmarksView())
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func searchTapped() {}
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewController = FeedDetailsViewController(view: FeedDetailsView())
        navigationController?.pushViewController(viewController, animated: true)
    }
}
