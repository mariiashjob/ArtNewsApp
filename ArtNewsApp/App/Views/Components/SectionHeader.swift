// SectionHeader.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 11.06.2026.

import Foundation
import SwiftUI

// MARK: - Section Header

struct SectionHeader: View {
    @Environment(\.theme) private var theme
    let title: String
    var actionTitle: String? = nil
    var action: () -> Void = {}

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.system(size: 17, weight: .bold))
               .foregroundColor(theme.textPrimary)
            Spacer()
            if let actionTitle {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(theme.primaryButton)
                }
            }
        }
        .padding(.horizontal, Padding.lg)
        .padding(.top, Padding.lg)
        .padding(.bottom, Padding.sm)
    }
}
