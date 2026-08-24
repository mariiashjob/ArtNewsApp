// ArticleMock.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 19.08.2026.

import Foundation

// MARK: - Article Mock

extension Article {
    static let mockArticles: [Article] = ResponseArticle.mockArticles.map {
        Article(
            title: $0.title,
            excerpt: $0.description,
            content: $0.content ?? "",
            category: ArticleCategory.allCases.randomElement() ?? .all,
            source: $0.source.name,
            author: $0.author,
            timeAgo: $0.publishedAt,
            readMinutes: Int.random(in: 1...30),
            likes: Int.random(in: 1...100),
            url: $0.url,
            urlToImage: $0.urlToImage
            )
    }
    
}
