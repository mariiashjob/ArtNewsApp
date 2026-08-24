// TopicCard.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 02.07.2026.

import SwiftUI

// MARK: - Topic Card

struct TopicCard: View {
    let category: ArticleCategory
    let count: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AbstractArtView(category: category, size: CGSize(width: 160, height: 80))
                .frame(height: 80)

            LinearGradient(
                colors: [.clear, .black.opacity(0.55)],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )

            HStack(alignment: .bottom) {
                Text(category.name)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text(count)
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.horizontal, Padding.md)
            .padding(.bottom, Padding.sm)
        }
        .clipShape(RoundedRectangle(cornerRadius: Radius.xl))
    }
}
