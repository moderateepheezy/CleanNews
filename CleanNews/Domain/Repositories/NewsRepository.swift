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
