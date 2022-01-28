//
//  NewsEventsToNewsItemMapper.swift
//  CleanNews
//
//  Created by Afees Lawal on 26.01.22.
//

import Foundation

class NewsEventsToNewsItemMapper {
    func map(newsEvents: NewsEvents) -> NewsItem {
        .init(
            feedListItemViewModels: newsEvents.articles.map(ArticleToFeedsListItemViewModelMapper().map),
            totalResults: newsEvents.totalResults ?? 0,
            page: newsEvents.page ?? 0,
            count: 0,
            pages: newsEvents.pages ?? 0
        )
    }

    func map(breakingEvent: BreakingNewsResponse.Events) -> NewsItem {
        .init(
            feedListItemViewModels: breakingEvent.articles.map(ArticleToFeedsListItemViewModelMapper().map),
            totalResults: breakingEvent.articles.count,
            page: 1,
            count: breakingEvent.articles.count,
            pages: 1
        )
    }
}
