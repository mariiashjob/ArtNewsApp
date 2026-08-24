// NewsResponse.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 01.06.2026.

// MARK: - Root Response

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ResponseArticle]
}
