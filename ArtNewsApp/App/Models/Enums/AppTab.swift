// AppTabs.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 17.06.2026.

import SwiftUI

// MARK: - App Tab

enum AppTab: CaseIterable, Codable, Hashable, Identifiable {
    case home
    case explore
    case saved
    case alerts
    case profile
    
    var id: Self { self }
    
    var icon: Image {
        switch self {
        case .home:         return AppIcons.houseFill
        case .explore:      return AppIcons.safariFill
        case .saved:        return AppIcons.bookmarkFill
        case .alerts:       return AppIcons.bellFill
        case .profile:      return AppIcons.personFill
        }
    }
    
    var label: String {
        switch self {
        case .home:         return Strings.Common.Menu.home
        case .explore:      return Strings.Common.Menu.explore
        case .saved:        return Strings.Common.Menu.saved
        case .alerts:       return Strings.Common.Menu.alerts
        case .profile:      return Strings.Common.Menu.profile
        }
    }
}
