//
//  ArticleToFeedsListItemViewModelMapper.swift
//  CleanNews
//
//  Created by Afees Lawal on 23.01.22.
//

import Foundation

final class ArticleToFeedsListItemViewModelMapper {
    func map(apiData: Article) -> FeedsListItemViewModel {
        .init(
            id: apiData.uri,
            sourceName: apiData.source?.title ?? "Unknown",
            newsImageUrl: apiData.image ?? "",
            newsTitle: apiData.title,
            sourceHost: apiData.source?.uri ?? "",
            content: apiData.body,
            dateTime: getTimeAgo(date: apiData.dateTime),
            category: getCategory(from: apiData.categories)
        )
    }

    func map(apiData: BreakingNewsResponse.Article) -> FeedsListItemViewModel {
        let source = getSource(apiData.infoArticle)
        return .init(
            id: apiData.infoArticle?.eng?.source?.uri ?? apiData.uri,
            sourceName: source.name,
            newsImageUrl: apiData.images?.first ?? "",
            newsTitle: apiData.title?.eng ?? "",
            sourceHost: source.host,
            content: getSummary(apiData.summary),
            dateTime: getTimeAgo(date: apiData.infoArticle?.eng?.dateTime),
            category: getCategory(from: apiData.categories)
        )
    }

    private func getSummary(_ summary: BreakingNewsResponse.Article.Summary?) -> String {
        summary?.eng ?? summary?.spa ?? summary?.por ?? ""
    }

    private func getSource(_ info: BreakingNewsResponse.Article.InfoArticle?) -> (name: String, host: String) {
        let source = info?.eng?.source ?? info?.spa?.source ?? info?.por?.source
        return (name: source?.title ?? "", host: source?.uri ?? "")
    }

    private func getCategory(from categories: [Categories]?) -> Category {
        for cat in categories ?? [] {
            for cas in Category.allCases {
                if let url = cat.label, url.lowercased().contains(cas.rawValue.lowercased()) {
                    return cas
                }
            }
        }
        return .business
    }

    private func getTimeAgo(date: Date?) -> String {
        guard let date = date else { return "Moments ago" }

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
