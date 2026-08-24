// HeaderView.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 17.06.2026.

import Foundation
import SwiftUI

// MARK: - Header View

struct HeaderView: View {
    @Environment(\.theme) private var theme
    
    // TODO: Move to VM
    private let userName = "ML"
    private let greeting = "GOOD MORNING"

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(greeting)
                    .font(.system(size: 12, weight: .medium))
                    .tracking(0.5)
                    .foregroundColor(theme.textSecondary)
                
                Text(Strings.Home.artboard)
                    .font(.system(size: 26, weight: .bold))
                    .tracking(-0.5)
                    .foregroundColor(theme.textPrimary)
            }
            
            Spacer()
            
            HStack(spacing: Spacing.md) {
                CircleIconButton(icon: AppIcons.magnifyingglass)
                
                // Avatar
                Text(userName)
                    .font(.system(size: 14, weight: .bold))
                   .foregroundColor(theme.textPrimary)
                    .frame(width: 36, height: 36)
                    .background(
                        LinearGradient(colors: [theme.accent, theme.accentLight],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .clipShape(Circle())
            }
        }
    }
}
