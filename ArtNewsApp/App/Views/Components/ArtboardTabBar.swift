// ArtboardTabBar.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 11.06.2026.

import Foundation
import SwiftUI

// MARK: - Artboard Tab Bar

struct ArtboardTabBar: View {
    @Environment(\.theme) private var theme
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Spacer()
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: Spacing.xs) {
                        ZStack(alignment: .topTrailing) {
                            tab.icon
                                .font(.system(size: 22))

                            // Unread badge on Alerts tab
                            if tab == .alerts {
                                BadgeView(alertsCount: 5)
                            }
                        }
                        Text(tab.label)
                            .font(.system(size: 10, weight: .semibold))
                    }
                    .foregroundColor(selectedTab == tab ? theme.accent : theme.accentPale)
                }
                Spacer()
            }
        }
        .padding(.top, Padding.sm)
        .padding(.bottom, Padding.xxl)
        .background(theme.background.opacity(0.97))
        .overlay(Divider().background(theme.chipBackground), alignment: .top)
    }
}
