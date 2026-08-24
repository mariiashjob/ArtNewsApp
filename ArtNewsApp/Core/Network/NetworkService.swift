// NetworkService.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 01.06.2026.

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    func fetchNews() async throws -> [ResponseArticle] {
        let urlString = Sources.newsURL
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let response = try JSONDecoder().decode(NewsResponse.self, from: data)
            return response.articles
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func fetchNews(page: Int) async throws -> [ResponseArticle] {
        guard let url = URL(string: "\(Sources.newsURL)&page=\(page)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let response = try JSONDecoder().decode(NewsResponse.self, from: data)
            return response.articles
        } catch {
            throw NetworkError.decodingError
        }
    }
}
