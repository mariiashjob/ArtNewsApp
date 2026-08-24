// SmallArticleCard.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 12.06.2026.

import SwiftUI

// MARK: - Small Trending Card

struct SmallArticleCard<Content: View>: View {
    @Environment(\.theme) private var theme
    @State private var showArticleDetail = false
    
    let article: Article
    let detail: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.zero) {
            ArticleImageView(article: article)
                .cornerRadius(Radius.md)
                .frame(width: 160)
            
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(article.category.name.uppercased())
                    .font(.system(size: 11, weight: .bold))
                    .tracking(0.5)
                    .foregroundColor(article.category.bgColor)
                
                Text(article.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(theme.textPrimary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(article.source)
                    .font(.system(size: 11))
                    .foregroundColor(theme.textMuted)
                    .padding(.top, Padding.xxs)
            }
            .padding(Padding.sm)
        }
        .frame(width: 160)
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Radius.md))
        .onTapGesture {
            showArticleDetail = true
        }
        .fullScreenCover(isPresented: $showArticleDetail) {
            detail
        }
    }
}
