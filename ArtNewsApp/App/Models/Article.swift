// Article.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 03.07.2026.

import Foundation

// MARK: - Article

struct Article: Codable, Identifiable, Equatable {
    let id = UUID()
    var title: String
    let excerpt: String?
    let content: String
    let category: ArticleCategory
    let source: String
    let author: String?
    let timeAgo: String
    let readMinutes: Int
    let likes: Int
    var url: String? = nil
    var urlToImage: String? = nil
    var isBookmarked: Bool = false
    var isFeatured: Bool = false
    var isOffline: Bool = false
    
    var initials: String? {
        author?
            .split(separator: " ")
            .compactMap { $0.first }.map { String($0) }
            .joined()
            .replacingOccurrences(of: " ", with: "")
            .uppercased()
    }
    
    var time: String {
        timeAgo
            .split(separator: "T")
            .map { String($0) }
            .first ?? ""
    }
    
    var readTime: LocalizedStringResource {
        return Strings.Artcile.readingTime(readMinutes.description)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, excerpt, content, category, source, author, timeAgo, readMinutes, likes, url, urlToImage, isBookmarked, isFeatured, isOffline
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.title == rhs.title && lhs.timeAgo == rhs.timeAgo
    }
}
