// NotificationRow.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 01.07.2026.

import Foundation
import SwiftUI

// MARK: - Notification Row

struct NotificationRow: View {
    @Environment(\.theme) private var theme
    
    let notification: AppNotification
    let isUnread: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Unread dot
            Circle()
                .fill(isUnread ? theme.primaryButton : Color.clear)
                .frame(width: 7, height: 7)
                .padding(.top, Padding.sm)

            // Icon
            ZStack {
                AbstractArtView(category: categoryForType(notification.type),
                                size: CGSize(width: 42, height: 42))
                    .frame(width: 42, height: 42)
                
                notification.type.icon
                    .font(.system(size: 16, weight: .semibold))
                   .foregroundColor(theme.textPrimary)
            }
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            .opacity(isUnread ? 1.0 : 0.45)

            // Body
            VStack(alignment: .leading, spacing: 4) {
                Group {
                    Text(notification.title)
                        .fontWeight(.bold)
                    
                    Text(notification.body)
                }
                .font(.system(size: 13))
                .foregroundColor(isUnread ? theme.textPrimary.opacity(0.9) : theme.textMuted)
                .lineLimit(3)

                HStack(spacing: Spacing.sm) {
                    if isUnread {
                        Text(notification.type.name)
                            .font(.system(size: 10, weight: .bold))
                        .foregroundColor(Color.white) //notification.type.bgColor
                        .padding(.horizontal, Padding.sm)
                        .padding(.vertical, Padding.xs)
                        .background(notification.type.bgColor)
                        .clipShape(RoundedRectangle(cornerRadius: Radius.xxs))
                    }

                    Text(notification.timeAgo)
                        .font(.system(size: 11))
                        .foregroundColor(theme.textDim)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, Padding.lg)
        .padding(.vertical, Padding.md)
        .background(isUnread ? theme.card : .clear)
    }

    private func categoryForType(_ type: AppNotification.NotificationType) -> ArticleCategory {
        switch type {
        case .artistUpdate:  return .painting
        case .exhibition:    return .exhibitions
        case .trending:      return .artMarket
        case .newWorks:      return .digitalArt
        case .digest:        return .sculpture
        }
    }
}
