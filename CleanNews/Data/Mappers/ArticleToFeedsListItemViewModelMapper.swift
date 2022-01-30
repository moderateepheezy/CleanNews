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
        guard let allPaths = categories?.compactMap(\.uri).joined(separator: "/").lowercased() else {
            return .general
        }

        let categoriesFromPath = allPaths.split(separator: "/").map { String($0) }
        var alFoundcategories: [Category?] = []
        for categoryPath in categoriesFromPath {
            let category = Category.allCases
                .first(where: {
                    $0.rawValue == categoryPath.lowercased() || categoryPath.contains($0.rawValue)

                })
            alFoundcategories.append(category)
        }

        let categoryWithHighestOccurrence = alFoundcategories.compactMap { $0 }.reduce([Category: Int]()) {
            var counts = $0
            counts[$1] = ($0[$1] ?? 0) + 1
            return counts
        }.max(by: { $0.1 < $1.1 })?.0

        return categoryWithHighestOccurrence ?? .general
    }

    private func getTimeAgo(date: Date?) -> String {
        guard let date = date else { return "Moments ago" }

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
