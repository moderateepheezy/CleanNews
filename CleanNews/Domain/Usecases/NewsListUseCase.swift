//
//  NewsListUseCase.swift
//  CleanNews
//
//  Created by Afees Lawal on 20.01.22.
//

import Foundation

final class NewsListUseCase {
    typealias Params = NewsRequestType
    typealias Response = NewsItem

    private let newsRepository: NewsRepository

    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
}

extension NewsListUseCase: UseCase {
    func execute(with params: Params, completion: @escaping Completion<Response>) {
        newsRepository.fetchNews(requestType: params, completion: completion)
    }
}
