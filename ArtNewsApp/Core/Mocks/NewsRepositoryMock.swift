// MockNewsRepository.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 08.06.2026.

import Foundation

// MARK: - News Repository Mock

final class NewsRepositoryMock: NewsRepositoryProtocol {
    
    var shouldFail = false
    
    func loadCachedNews() throws -> [Article] {
        return Article.mockArticles
    }
    
    func fetchNews() async throws -> [ResponseArticle] {
        if shouldFail {
            throw NetworkError.serverError
        }
        
        return ResponseArticle.mockArticles
    }
    
    func fetchNews(page: Int) async throws -> [ResponseArticle] {
        if shouldFail {
            throw NetworkError.serverError
        }
        
        return ResponseArticle.mockArticles.dropLast(page)
    }
}
