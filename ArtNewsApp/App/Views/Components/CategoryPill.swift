// CategoryPill.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 11.06.2026.

import Foundation
import SwiftUI

// MARK: - Category Pill

struct CategoryPill: View {
    @Environment(\.theme) private var theme
    
    let category: ArticleCategory
    let isSelected: Bool

    var body: some View {
        Text(category.name)
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(isSelected ? .white : theme.textMuted)
            .padding(.horizontal, Padding.lg)
            .padding(.vertical, Padding.sm)
            .background(isSelected ?theme.badge : theme.chipBackground)
            .clipShape(Capsule())
    }
}

#Preview {
    CategoryPill(category: .all, isSelected: true)
        .preferredColorScheme(.dark)
}
