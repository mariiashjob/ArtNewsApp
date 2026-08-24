// MenuRow.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 02.07.2026.

import SwiftUI

// MARK: - Menu Row

struct MenuRow: View {
    @Environment(\.theme) private var theme
    
    let icon: Image
    let iconBg: Color
    let iconColor: Color
    let label: String
    var trailing: String? = nil

    var body: some View {
        HStack(spacing: Spacing.md) {
            icon
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(iconColor)
                .frame(width: 32, height: 32)
                .background(iconBg)
                .clipShape(RoundedRectangle(cornerRadius: Radius.xs))

            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(theme.textPrimary)

            Spacer()

            if let trailing {
                Text(trailing)
                    .font(.system(size: 12))
                    .foregroundColor(theme.textMuted)
            }

            AppIcons.chevronRight
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(Color(hex: "#333333"))
        }
        .padding(.horizontal, Padding.md)
        .padding(.vertical, Padding.md)
    }
}

