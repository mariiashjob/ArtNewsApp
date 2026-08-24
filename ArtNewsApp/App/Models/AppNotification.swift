// AppNotification.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 03.07.2026.

import SwiftUI

// MARK: - Notification

struct AppNotification: Identifiable {
    let id = UUID()
    let title: String
    let body: String
    let type: NotificationType
    let timeAgo: String
    var isRead: Bool

    enum NotificationType {
        case artistUpdate
        case exhibition
        case trending
        case newWorks
        case digest
        
        var name: String {
            switch self {
            case .artistUpdate: return Strings.Notification.artistUpdate
            case .exhibition:   return Strings.Notification.exhibition
            case .trending:     return Strings.Notification.trending
            case .newWorks:     return Strings.Notification.newWorks
            case .digest:       return Strings.Notification.weeklyDigest
            }
        }
        
        var bgColor: Color {
            switch self {
            case .artistUpdate: return Color(hex: "#0d2a0d")
            case .exhibition:   return Color(hex: "#0d2a0d")
            case .trending:     return Color(hex: "#250833")
            case .newWorks:     return Color(hex: "#0a1828")
            case .digest:       return Color(hex: "#251008")
            }
        }
        var icon: Image {
            switch self {
            case .artistUpdate: return AppIcons.personFill
            case .exhibition:   return AppIcons.calendar
            case .trending:     return AppIcons.chartLineUptrendXyaxis
            case .newWorks:     return AppIcons.paintpaletteFill
            case .digest:       return AppIcons.newspaperFill
            }
        }
    }
}
