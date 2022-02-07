//
//  DefaultNewsRepository.swift
//  CleanNews
//
//  Created by Afees Lawal on 07.02.22.
//

import Foundation

final class DefaultNewsRepository: NewsRepository {
    private let networkService: NetworkService
    private let apiKey: String

    init(networkService: NetworkService, apiKey: String) {
        self.networkService = networkService
        self.apiKey = apiKey
    }

    func fetchNews(requestType: NewsRequestType, completion: @escaping (Result<NewsItem, Error>) -> Void) {
        switch requestType {
        case .heading:
            fetchNewsHeader(completion: completion)
        case let .all(page):
            fetchAllNews(page: page, completion: completion)
        }
    }

    private func fetchAllNews(page: Int, completion: @escaping (Result<NewsItem, Error>) -> Void) {
        var params: [String: Any] = [:]
        params["sourceLocationUri"] = "http://en.wikipedia.org/wiki/United_States"
        params["resultType"] = "articles"
        params["includeArticleCategories"] = true
        params["includeCategoryParentUri"] = true
        params["articlesPage"] = page
        params["articlesCount"] = 20
        params["articlesSortBy"] = "date"
        params["dataType"] = ["news", "pr", "blog"]
        params["apiKey"] = apiKey

        let requestConfig = RequestConfig(path: "article/getArticles", params: params)

        networkService.request(endpoint: APIRequest.request(requestConfig)) { (result: Swift.Result<NewsAPIResponse, Error>) in
            switch result {
            case let .success(response):
                completion(.success(NewsEventsToNewsItemMapper().map(newsEvents: response.events)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func fetchNewsHeader(completion: @escaping (Result<NewsItem, Error>) -> Void) {
        var params: [String: Any] = [:]
        params["eventImageCount"] = 3
        params["includeEventInfoArticle"] = true
        params["breakingEventsCount"] = 10
        params["includeEventConcepts"] = false
        params["apiKey"] = apiKey

        let requestConfig = RequestConfig(path: "event/getBreakingEvents", params: params)

        networkService.request(endpoint: APIRequest.request(requestConfig)) { (result: Swift.Result<BreakingNewsResponse, Error>) in
            switch result {
            case let .success(response):
                completion(.success(NewsEventsToNewsItemMapper().map(breakingEvent: response.events)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
