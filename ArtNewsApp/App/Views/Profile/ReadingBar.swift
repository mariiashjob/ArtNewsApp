// ReadingBar.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 02.07.2026.

import SwiftUI

// MARK: - Reading Bar

struct ReadingBar: View {
    @Environment(\.theme) private var theme
    
    let category: ArticleCategory
    let percentage: Double

    var body: some View {
        HStack(spacing: Spacing.md) {
            Text(category.name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(theme.textSecondary)
                .frame(width: 80, alignment: .leading)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.darkRed)
                    Capsule()
                        .fill(category.bgColor)
                        .frame(width: geo.size.width * percentage)
                }
            }
            .frame(height: 5)

            Text("\(Int(percentage * 100))%")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(theme.textDim)
                .frame(width: 30, alignment: .trailing)
        }
        .padding(.horizontal, Padding.md)
        .padding(.vertical, Padding.md)
    }
}
