//
//  NewsItem.swift
//  CleanNews
//
//  Created by Afees Lawal on 20.01.22.
//

import Foundation

struct NewsItem: Equatable {
    let feedListItemViewModels: [FeedsListItemViewModel]
    let totalResults: Int
    let page: Int
    let count: Int
    let pages: Int
}
