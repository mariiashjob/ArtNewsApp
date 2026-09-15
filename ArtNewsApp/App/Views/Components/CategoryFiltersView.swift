// CategoryFiltersView.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 17.06.2026.

import Foundation
import SwiftUI

// MARK: - Category Filters

struct CategoryFiltersView: View {
    @State private var selectedCategory: ArticleCategory = .all
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.md) {
                ForEach(ArticleCategory.allCases, id: \.self) { category in
                    CategoryPill(category: category, isSelected: selectedCategory == category)
                        .onTapGesture { selectedCategory = category }
                }
            }
            .padding(.horizontal, Padding.lg)
        }
    }
}
