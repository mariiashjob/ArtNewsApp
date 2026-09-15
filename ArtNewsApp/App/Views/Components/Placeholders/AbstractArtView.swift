// AbstractArtView.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 11.06.2026.

import Foundation
import SwiftUI

// MARK: - Abstract Art Placeholder
/// Generates a unique generative-art style gradient background per category.

struct AbstractArtView: View {
    @Environment(\.theme) private var theme
    let category: ArticleCategory
    let size: CGSize

    var body: some View {
        ZStack {
            category.bgColor.opacity(0.6)
            // Soft glow blobs
            Circle()
                .fill(category.bgColor.opacity(0.25))
                .frame(width: size.width * 0.8)
                .offset(x: -size.width * 0.2, y: -size.height * 0.2)
            Circle()
                .fill(theme.primaryButtonText.opacity(0.12))
                .frame(width: size.width * 0.6)
                .offset(x: size.width * 0.25, y: size.height * 0.2)
            // Decorative ring
            Circle()
                .strokeBorder(category.bgColor.opacity(0.3), lineWidth: 1.5)
                .frame(width: size.width * 0.55)
            Circle()
                .fill(category.bgColor.opacity(0.4))
                .frame(width: size.width * 0.12)
            Circle()
                .fill(Color.white.opacity(0.7))
                .frame(width: size.width * 0.05)
        }
        .clipShape(Rectangle())
    }
}
