//
//  NewsRepository.swift
//  CleanNews
//
//  Created by Afees Lawal on 20.01.22.
//

import Foundation

protocol NewsRepository {
    func fetchNews(requestType: NewsRequestType, completion: @escaping (Result<NewsItem, Error>) -> Void)
}

// For Top headings: https://newsapi.org/v2/top-headlines/sources?country=us&apiKey=23e7b8299b7c494bb4e687fc4ee401a7
// By Category: https://newsdata.io/api/1/sources?category=food&apikey=pub_3792b071b02bb42a5635646637e7127d6391&page=1+
// For All: https://newsapi.org/v2/top-headlines/sources?country=us&apiKey=23e7b8299b7c494bb4e687fc4ee401a7&page=2+

// For Search: https://newsapi.org/v2/everything?q=bitcoin&apiKey=23e7b8299b7c494bb4e687fc4ee401a7 but return nil Category

// For Logo : https://logo.clearbit.com/{hostname}

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
        params["apiKey"] = apiKey
        params["includeArticleCategories"] = true
        params["includeCategoryParentUri"] = true
        params["articlesPage"] = page
        params["articlesCount"] = 20
        params["articlesSortBy"] = "date"
        params["dataType"] = ["news", "pr", "blog"]

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
