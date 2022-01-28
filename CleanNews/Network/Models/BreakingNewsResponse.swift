//
//  BreakingNewsResponse.swift
//  CleanNews
//
//  Created by Afees Lawal on 26.01.22.
//

import Foundation

struct BreakingNewsResponse: Decodable {
    let events: Events

    enum CodingKeys: String, CodingKey {
        case events = "breakingEvents"
    }

    struct Events: Decodable {
        let articles: [BreakingNewsResponse.Article]

        enum CodingKeys: String, CodingKey {
            case articles = "results"
        }
    }

    struct Article: Decodable {
        let uri: String
        let eventDate: String
        let title: Summary?
        let summary: Summary?
        let infoArticle: InfoArticle?
        let categories: [Categories]?
        let images: [String]?

        struct Summary: Decodable {
            let spa, por, eng: String?
        }

        struct InfoArticle: Decodable {
            let spa, por, eng: Eng?
        }

        // MARK: - Eng

        struct Eng: Decodable {
            let dateTime, dateTimePub: Date?
            let url: String
            let source: NewsSource?
        }
    }
}
