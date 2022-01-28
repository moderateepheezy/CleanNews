//
//  Article.swift
//  CleanNews
//
//  Created by Afees Lawal on 26.01.22.
//

import Foundation

// MARK: - Article

struct Article: Decodable {
    let uri: String
    let title: String
    let body: String
    let image: String?
    let source: NewsSource?
    let categories: [Categories]?
    let dateTime: Date?

    enum CodingKeys: String, CodingKey {
        case title, uri, image, body, categories, source, dateTime
    }
}

// MARK: - Categories

struct Categories: Decodable {
    let uri: String?
    let label: String?
}
