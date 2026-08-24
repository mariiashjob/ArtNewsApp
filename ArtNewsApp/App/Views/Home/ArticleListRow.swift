// File.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 12.06.2026.

import SwiftUI

// MARK: - Latest Stories List Row

struct ArticleListRow<Content: View>: View {
    @Environment(\.theme) private var theme
    @State private var showArticleDetail = false
    
    let article: Article
    let detail: Content
    
    var body: some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            ArticleImageView(article: article)
                .cornerRadius(Radius.md)
                .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(article.category.name.uppercased())
                    .font(.system(size: 11, weight: .bold))
                    .tracking(0.5)
                    .foregroundColor(article.category.bgColor)

                Text(article.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(theme.textPrimary)
                    .lineLimit(2)

                HStack(spacing: Spacing.sm) {
                    Text(article.source)
                        .font(.system(size: 12))
                        .foregroundColor(theme.textMuted)
                    Circle()
                        .fill(theme.chipBackground)
                        .frame(width: 3, height: 3)
                    Text(article.timeAgo)
                        .font(.system(size: 11))
                        .foregroundColor(theme.textSecondary)
                }
            }
            
            Spacer()
        }
        .frame(height: 72)
        .padding(.vertical, Padding.lg)
        .onTapGesture {
            showArticleDetail = true
        }
        .fullScreenCover(isPresented: $showArticleDetail) {
            detail
        }
    }
}
