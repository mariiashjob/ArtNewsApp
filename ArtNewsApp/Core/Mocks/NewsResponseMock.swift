// NewsResponse+Extension.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 04.06.2026.

import Foundation

// MARK: - News Response Mock

extension NewsResponse {
    static let mock = NewsResponse(
        status: "ok",
        totalResults: 31471,
        articles: ResponseArticle.mockArticles
    )
}
