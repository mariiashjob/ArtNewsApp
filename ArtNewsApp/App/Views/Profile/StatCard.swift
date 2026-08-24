// StatCard.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 02.07.2026.

import SwiftUI

// MARK: - Stat Card

struct StatCard: View {
    @Environment(\.theme) private var theme
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: Spacing.sm) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(theme.textPrimary)
            
            Text(label.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .tracking(0.4)
                .foregroundColor(theme.textMuted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Padding.sm)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Padding.md)
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .overlay(
            RoundedRectangle(cornerRadius: Radius.lg)
                .stroke(theme.border, lineWidth: 0.5)
        )
    }
}
