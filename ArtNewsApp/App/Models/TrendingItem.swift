// TrendingItem.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 03.07.2026.

import Foundation

// MARK: - TrendingItem

struct TrendingItem: Identifiable {
    let id = UUID()
    let rank: Int
    let title: String
    let category: ArticleCategory
    let readCount: String
    let source: String
}
