// ArticleCollection.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 03.07.2026.

import SwiftUI

// MARK: - Collection

struct ArticleCollection: Identifiable {
    let id = UUID()
    let name: String
    let count: Int
    let accentColor: Color
    let category: ArticleCategory
}
