//
//  NewsAPIResponse.swift
//  CleanNews
//
//  Created by Afees Lawal on 20.01.22.
//

import Foundation

// MARK: - NewsAPIResponse

struct NewsAPIResponse: Decodable {
    let events: NewsEvents
    enum CodingKeys: String, CodingKey {
        case events = "articles"
    }
}

// MARK: - NewsEvents

struct NewsEvents: Decodable {
    let articles: [Article]
    let totalResults: Int?
    let page: Int?
    let pages: Int?

    enum CodingKeys: String, CodingKey {
        case articles = "results"
        case totalResults, page, pages
    }
}
