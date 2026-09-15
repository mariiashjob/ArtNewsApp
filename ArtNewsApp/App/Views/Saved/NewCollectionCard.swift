// NewCollectionCard.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 29.06.2026.

import Foundation
import SwiftUI

// MARK: - New Collection Card

struct NewCollectionCard: View {
    @Environment(\.theme) private var theme
    
    var body: some View {
        VStack(spacing: Spacing.sm) {
            AppIcons.plus
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(theme.textPrimary)
                .frame(width: 36, height: 36)
                .background(theme.badge)
                .clipShape(Circle())

            Text(Strings.Saved.newCollection)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(theme.textMuted)
                .multilineTextAlignment(.center)
        }
        .frame(width: 130, height: 130)
        .background(theme.heroBackground)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
