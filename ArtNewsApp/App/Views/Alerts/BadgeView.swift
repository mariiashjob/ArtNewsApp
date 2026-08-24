// BadgeView.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 17.06.2026.

import Foundation
import SwiftUI

// MARK: - Badge View

struct BadgeView: View {
    @Environment(\.theme) private var theme
    let alertsCount: Int
    
    var body: some View {
        Text(alertsCount.description)
            .font(.system(size: 8, weight: .bold))
            .foregroundColor(theme.badgeText)
            .frame(width: 14, height: 14)
            .background(theme.accent)
            .clipShape(Circle())
            .overlay(Circle().stroke(theme.badge, lineWidth: 2))
            .offset(x: 6, y: -4)
    }
}
