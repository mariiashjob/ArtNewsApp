// ArtNewsApp.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 01.06.2026.

import Foundation

// MARK: - ResponseArticle

struct ResponseArticle: Codable, Identifiable, Equatable {
    let id = UUID()
    let source: ResponseSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
 
    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
 
    var publishedDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: publishedAt)
    }
    
    static func == (lhs: ResponseArticle, rhs: ResponseArticle) -> Bool {
        lhs.url == rhs.url
    }
}

// MARK: - ResponseSource

struct ResponseSource: Codable, Identifiable, Equatable {
    let id: String?
    let name: String
}

// MARK: - ResponseArticle Decoder

extension ResponseArticle {
    static var decoder: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }
}
