// FavoritesManagerProtocol.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 08.06.2026.

protocol FavoritesManagerProtocol {
    func saveFavorites(_ articles: [Article])
    func loadFavorites() -> [Article]
}
