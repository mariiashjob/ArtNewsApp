// FeaturedArticleCard.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 12.06.2026.

import SwiftUI

// MARK: - Featured Article Card

struct FeaturedArticleCard<Content: View>: View {
    @Environment(\.theme) private var theme
    @State private var showArticleDetail = false
    
    let article: Article
    let detail: Content

    var body: some View {
        ZStack(alignment: .topLeading) {
            ArticleImageView(article: article)
                .cornerRadius(Radius.md)
                .frame(width: screenWidth - 40, height: 220)

            // Gradient overlay
            LinearGradient(
                colors: [.clear, .black.opacity(0.85)],
                startPoint: .center,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: Spacing.zero) {
                // Badge
                Text(Strings.Common.featured)
                    .font(.system(size: 11, weight: .bold))
                    .tracking(0.5)
                   .foregroundColor(theme.textPrimary)
                    .padding(.horizontal, Padding.sm)
                    .padding(.vertical, Padding.xs)
                    .background(theme.accent)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.xs))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(Padding.md)
                    .offset(x: -Padding.md)

                Spacer()

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(article.title)
                        .font(.system(size: 17, weight: .bold))
                       .foregroundColor(theme.textPrimary)
                        .lineLimit(2)

                    HStack(spacing: Spacing.sm) {
                        Text(article.source)
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                        Circle()
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 3, height: 3)
                        Text(article.timeAgo)
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
                .padding(Padding.md)
            }
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: Radius.xxl))
        .padding(.horizontal, Padding.lg)
        .onTapGesture {
            showArticleDetail = true
        }
        .fullScreenCover(isPresented: $showArticleDetail) {
            detail
        }
    }
}
