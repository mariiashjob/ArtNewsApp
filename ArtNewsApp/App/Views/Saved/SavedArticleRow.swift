// SavedArticleRow.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 29.06.2026.

import Foundation
import SwiftUI

// MARK: - Saved Article Row

struct SavedArticleRow<Content: View>: View {
    @Environment(\.theme) private var theme
    
    @State private var showArticleDetail = false
    
    let article: Article
    let detail: Content
    var bookmarkAction: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            ArticleImageView(article: article)
                .cornerRadius(Radius.md)
                .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 4) {
                Text(article.category.name.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .tracking(0.5)
                    .foregroundColor(article.category.bgColor)

                Text(article.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(theme.textPrimary)
                    .lineLimit(2)

                HStack(spacing: Spacing.sm) {
                    Text(article.source)
                        .font(.system(size: 11))
                        .foregroundColor(theme.textMuted)
                    Circle().fill(theme.border).frame(width: 2, height: 2)
                    Text(Strings.Saved.savedTime(article.timeAgo))
                        .font(.system(size: 11))
                        .foregroundColor(theme.textDim)
                }

                if article.isOffline {
                    Label {
                        Text(Strings.Saved.offline)
                            .font(.system(size: 10, weight: .bold))
                    } icon: {
                        AppIcons.wifiSlash
                    }
                    .foregroundColor(theme.accentLight)
                    .padding(.horizontal, Padding.sm)
                    .padding(.vertical, Padding.xxs)
                    .background(theme.textDim)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.xxs))
                }
            }

            //Spacer()

            AppIcons.bookmarkFill
                .font(.system(size: 18))
                .foregroundColor(theme.primaryButton)
                .padding(.top, Padding.lg)
                .onTapGesture {
                    bookmarkAction()
                }
        }
        .padding(.vertical, Padding.lg)
        .onTapGesture {
            showArticleDetail = true
        }
        .fullScreenCover(isPresented: $showArticleDetail) {
            detail
        }
    }
}
