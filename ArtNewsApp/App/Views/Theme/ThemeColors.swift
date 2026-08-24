// ThemeColurs.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 29.07.2026.

import Foundation
//
//  TwoColumnScrollView.swift
//
//  Scrollable view with two columns:
//  • Left  — text (title + subtitle)
//  • Right — coloured circle with an icon/label inside
//

import SwiftUI

// MARK: - Model

struct ColorThemeItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let color: Color
    let icon: String      // SF Symbol name shown inside the circle
}


// MARK: - Main View

struct TwoColumnScrollView: View {

    let theme: AppTheme
    let variableNames: [String]

    init() {
        self.theme = VioletNightTheme()
        let mirror = Mirror(reflecting: theme)
        self.variableNames = mirror.children
            .compactMap { $0.label }
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack(spacing: Spacing.zero) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Spacing.md) {
                        Text(theme.displayName)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                        
                        RowCard(
                            title: "background",
                            color: theme.background
                        )
                        
                        RowCard(
                            title: "card",
                            color: theme.card
                        )
                        
                        RowCard(
                            title: "divider",
                            color: theme.divider
                        )
                        
                        RowCard(
                            title: "accent",
                            color: theme.accent
                        )
                        
                        RowCard(
                            title: "accentLight",
                            color: theme.accentLight
                        )
                           
                        RowCard(
                            title: "badge",
                            color: theme.badge
                        )
                        
                        RowCard(
                            title: "badgeText",
                            color: theme.badgeText
                        )
                        
                        RowCard(
                            title: "textPrimary",
                            color: theme.textPrimary
                        )
                        
                        RowCard(
                            title: "textSecondary",
                            color: theme.textSecondary
                        )
                        
                        RowCard(
                            title: "textMuted",
                            color: theme.textMuted
                        )
                        
                        RowCard(
                            title: "textDim",
                            color: theme.textDim
                        )
                        
                        RowCard(
                            title: "chipBackground",
                            color: theme.chipBackground
                        )
                        
                        RowCard(
                            title: "surface",
                            color: theme.surface
                        )
                        
                        RowCard(
                            title: "border",
                            color: theme.border
                        )
                        
                        RowCard(
                            title: "progressFill",
                            color: theme.progressFill
                        )
                        
                        RowCard(
                            title: "theme.authorAvatar",
                            color: theme.authorAvatar
                        )
                        
                        RowCard(
                            title: "authorAvatarText",
                            color: theme.authorAvatarText
                        )
                        
                        RowCard(
                            title: "heroBackground",
                            color: theme.heroBackground
                        )
                        
                        RowCard(
                            title: "heroBlob1",
                            color: theme.heroBlob1
                        )
                        
                        RowCard(
                            title: "heroBlob2",
                            color: theme.heroBlob2
                        )
                        
                        RowCard(
                            title: "heroBlob3",
                            color: theme.heroBlob3
                        )
                        
                        RowCard(
                            title: "primaryButton",
                            color: theme.primaryButton
                        )
                        
                        RowCard(
                            title: "primaryButtonText",
                            color: theme.primaryButtonText
                        )
                        
                        RowCard(
                            title: "secondaryButton",
                            color: theme.secondaryButton
                        )
                        
                        RowCard(
                            title: "primaryButtonText",
                            color: theme.primaryButtonText
                        )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
            }
        }
}

// MARK: - Row Card

private struct RowCard: View {
    let title: String
    let color: Color

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ColorCircle(color: color)
            
            Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Colour Circle

private struct ColorCircle: View {
    let color: Color

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 66, height: 66)
    }
}

// MARK: - Preview

#Preview("Theme Colors") {
    TwoColumnScrollView()
}
