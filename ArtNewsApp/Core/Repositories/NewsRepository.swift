// NewsRepository.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 05.06.2026.

import Foundation

final class NewsRepository: NewsRepositoryProtocol {
    private let service: NetworkService
    private let localStorage: LocalNewsStorageProtocol

    init(
        service: NetworkService,
        localStorage: LocalNewsStorageProtocol
    ) {
        self.service = service
        self.localStorage = localStorage
    }
    
    func fetchNews() async throws -> [ResponseArticle] {
        try await service.fetchNews()
    }

    func fetchNews(page: Int) async throws -> [ResponseArticle] {
        do {
            let responseArticles = try await service.fetchNews(page: page)
            let articles = responseArticles.map {
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

            try localStorage.save(
                articles,
                for: page
            )

            return responseArticles

        } catch {
            throw error
        }
    }

    func loadCachedNews() throws -> [Article] {
        try localStorage.loadAll()
    }
}
