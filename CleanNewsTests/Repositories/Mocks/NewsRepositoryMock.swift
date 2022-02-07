//
//  NewsRepositoryMock.swift
//  CleanNewsTests
//
//  Created by Afees Lawal on 03.02.22.
//

@testable import CleanNews
import Foundation
import XCTest

final class NewsRepositoryMock: NewsRepository {
    func fetchNews(requestType _: NewsRequestType, completion _: @escaping (Result<NewsItem, Error>) -> Void) {}
}
