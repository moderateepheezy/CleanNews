//
//  HomeViewModel.swift
//  CleanNews
//
//  Created by Afees Lawal on 19.01.22.
//

import Foundation

protocol HomeViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSelect(at indexPath: IndexPath)
}

enum ViewModelLoadingState {
    case fullScreen
    case nextPage
}

protocol HomeVieWModelOutput {
    var newsListItems: Observable<[FeedsListItemViewModel]?> { get }
    var newsHeaderListItems: Observable<[FeedsListItemViewModel]?> { get }
    var loading: Observable<ViewModelLoadingState?> { get }
    var error: Observable<String> { get }
}

protocol HomeViewModelType: HomeViewModelInput, HomeVieWModelOutput {}

final class HomeViewModel: HomeViewModelType {
    var newsListItems: Observable<[FeedsListItemViewModel]?> = Observable(.none)
    var newsHeaderListItems: Observable<[FeedsListItemViewModel]?> = Observable(.none)
    var loading: Observable<ViewModelLoadingState?> = Observable(.none)
    var error: Observable<String> = Observable("")

    init(newsListUseCase: NewsListUseCase) {
        self.newsListUseCase = newsListUseCase
    }

    func viewDidLoad() {
        loading.value = .fullScreen
        newsListUseCase.execute(requestType: .all(page: 1)) { result in
            switch result {
            case let .success(response):
                self.newsListItems.value = response.feedListItemViewModels
            case let .failure(error):
                self.error.value = error.localizedDescription
            }
            self.loading.value = .none
        }

        newsListUseCase.execute(requestType: .heading) { result in
            switch result {
            case let .success(response):
                self.newsHeaderListItems.value = response.feedListItemViewModels
            case let .failure(error):
                self.error.value = error.localizedDescription
            }
        }
    }

    func didLoadNextPage() {}

    func didSelect(at _: IndexPath) {}

    // MARK: - Private

    private let newsListUseCase: NewsListUseCase
}
