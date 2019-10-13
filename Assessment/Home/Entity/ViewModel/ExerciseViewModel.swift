//
//  HomeViewModel.swift
//  Assessment
//
//  Created by Omika Garg on 10/10/19.
//  Copyright © 2019 Akshay Garg. All rights reserved.
//

import Foundation

/// Article View Model.
protocol ArticleViewModel {
    var displayHeaderTitle: String? { get }
    var displayTitle: String? { get }
    var displayWebsite: String? { get }
    var displayAuthors: String? { get }
    var displayDate: String? { get }
    var displayContent: String? { get }
    var displayImageURL: String? { get }
}

// MARK: - Article View Model.
extension RealmArticle: ArticleViewModel {
    var displayHeaderTitle: String? {
        return headerTitle
    }
    var displayTitle: String? {
        return title
    }
    var displayWebsite: String? {
        return website
    }
    var displayAuthors: String? {
        return authors
    }
    var displayDate: String? {
        return date
    }
    var displayContent: String? {
        return content
    }
    var displayImageURL: String? {
        return imageURL
    }
}
