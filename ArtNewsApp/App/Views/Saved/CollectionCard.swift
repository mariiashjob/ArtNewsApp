// CollectionCard.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 29.06.2026.

import Foundation
import SwiftUI

// MARK: - Collection Card

struct CollectionCard: View {
    @Environment(\.theme) private var theme
    
    let collection: ArticleCollection
    let category: ArticleCategory

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.zero) {
            AbstractArtView(
                category: category,
                size: CGSize(width: 130, height: 88)
            )
            .frame(width: 130, height: 88)
            
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(collection.name)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(theme.textPrimary)
                Text(Strings.Saved.artcilesRead(collection.count))
                    .font(.system(size: 11))
                    .foregroundColor(theme.textMuted)
            }
            .padding(Padding.md)
        }
        .frame(width: 130, height: 130)
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
