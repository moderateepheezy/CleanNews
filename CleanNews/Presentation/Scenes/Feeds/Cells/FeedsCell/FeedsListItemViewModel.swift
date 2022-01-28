//
//  FeedsListItemViewModel.swift
//  CleanNews
//
//  Created by Afees Lawal on 19.01.22.
//

import Foundation

struct FeedsListItemViewModel: Equatable, Hashable, Identifiable {
    let id: String
    let sourceName: String
    let newsImageUrl: String
    let newsTitle: String
    let sourceHost: String
    let content: String
    let dateTime: String
    let category: Category

    var sourceImageURL: URL? {
        URL(string: "https://logo.clearbit.com/\(sourceHost)")
    }

    var newsImageURL: URL? {
        URL(string: newsImageUrl)
    }
}
