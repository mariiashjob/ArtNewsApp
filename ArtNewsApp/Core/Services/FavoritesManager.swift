// FavoritesManager.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 04.06.2026.

import Foundation

class FavoritesManager: FavoritesManagerProtocol {
    
    private let key = "favorite_articles"
    
    func saveFavorites(_ articles: [Article]) {
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func loadFavorites() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let articles = try? JSONDecoder().decode([Article].self, from: data)
        else {
            return []
        }
        return articles
    }
}
