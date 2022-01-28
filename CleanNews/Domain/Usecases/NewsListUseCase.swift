//
//  NewsListUseCase.swift
//  CleanNews
//
//  Created by Afees Lawal on 20.01.22.
//

import Foundation

protocol NewsListUseCase {
    func execute(requestType: NewsRequestType, completion: @escaping (Result<NewsItem, Error>) -> Void)
}

final class DefaultNewsListUseCase: NewsListUseCase {
    private let newsRepository: NewsRepository

    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }

    func execute(requestType: NewsRequestType, completion: @escaping (Result<NewsItem, Error>) -> Void) {
        newsRepository.fetchNews(requestType: requestType) { result in
            completion(result)
        }
    }
}
