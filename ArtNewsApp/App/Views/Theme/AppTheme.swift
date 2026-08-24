//
//  AppTheme.swift
//  ThemeSystem
//
//  Contains:
//  1. AppTheme protocol  — the shape every theme must implement
//  2. Five concrete themes
//  3. ThemeManager      — @EnvironmentObject that owns the active theme
//                         and persists the user's choice to UserDefaults
//

import SwiftUI
internal import Combine

// ─────────────────────────────────────────────────────────────────────────────
// MARK: - 1. Protocol
// ─────────────────────────────────────────────────────────────────────────────

/// Every theme provides the same semantic color slots.
/// Views reference *slots*, never raw hex — so swapping a theme requires
/// zero changes to the view layer.
protocol AppTheme {
    var id: String          { get }
    var displayName: String { get }
    var isDark: Bool        { get }

    // Surfaces
    var background: Color   { get }
    var card: Color         { get }
    var divider: Color     { get }

    // Brand / accent
    var accent: Color       { get }
    var accentLight: Color  { get }
    var accentPale: Color   { get }
    var badge: Color        { get }      
    var badgeText: Color    { get }

    // Text
    var textPrimary: Color  { get }
    var textSecondary: Color { get }
    var textMuted: Color    { get }
    var textDim: Color      { get }

    // Components
    var chipBackground: Color   { get }
    var surface: Color  { get }
    var border: Color      { get }
    var progressFill: Color     { get }
    var authorAvatar: Color     { get }
    var authorAvatarText: Color { get }

    // Hero
    var heroBackground: Color   { get }
    var heroBlob1: Color        { get }
    var heroBlob2: Color        { get }
    var heroBlob3: Color        { get }

    // Buttons
    var primaryButton: Color    { get }
    var primaryButtonText: Color { get }
    var secondaryButton: Color  { get }
    var secondaryButtonText: Color { get }

    // Color scheme hint for SwiftUI
    var colorScheme: ColorScheme { get }
}

extension AppTheme {
    var colorScheme: ColorScheme { isDark ? .dark : .light }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: - 2. Themes
// ─────────────────────────────────────────────────────────────────────────────

// MARK: Violet Night (original dark purple)
struct VioletNightTheme: AppTheme {
    let id = "violet_night"
    let displayName = "Violet Night"
    let isDark = true

    let background    = Color(hex: "#0a0a0a")
    let card          = Color(hex: "#141414")
    let divider       = Color(hex: "#181818")

    let accent        = Color(hex: "#7c3aed")
    let accentLight   = Color(hex: "#a78bfa")
    let accentPale    = Color(hex: "#c4b8ff")
    let badge         = Color(hex: "#7c3aed")
    let badgeText     = Color(hex: "#ede9fe")

    let textPrimary   = Color(hex: "#e0d8ff")
    let textSecondary = Color(hex: "#c4b8ff")
    let textMuted     = Color(hex: "#888888")
    let textDim       = Color(hex: "#555555")

    let chipBackground   = Color(hex: "#1a1a1a")
    let surface          = Color(hex: "#110820")
    let border           = Color(hex: "#7c3aed")
    let progressFill     = Color(hex: "#7c3aed")
    let authorAvatar     = Color(hex: "#2d1b69")
    let authorAvatarText = Color(hex: "#a78bfa")

    let heroBackground = Color(hex: "#12082e")
    let heroBlob1      = Color(hex: "#7c3aed")
    let heroBlob2      = Color(hex: "#a78bfa")
    let heroBlob3      = Color(hex: "#e879f9")

    let primaryButton       = Color(hex: "#7c3aed")
    let primaryButtonText   = Color.white
    let secondaryButton     = Color(hex: "#1a1a1a")
    let secondaryButtonText = Color(hex: "#a78bfa")
}

// MARK: Ember Dark (warm charcoal + amber)
struct EmberDarkTheme: AppTheme {
    let id = "ember_dark"
    let displayName = "Ember Dark"
    let isDark = true

    let background    = Color(hex: "#0f0a00")
    let card          = Color(hex: "#1a1208")
    let divider       = Color(hex: "#231900")

    let accent        = Color(hex: "#f59e0b")
    let accentLight   = Color(hex: "#fbbf24")
    let accentPale    = Color(hex: "#fde68a")
    let badge         = Color(hex: "#92400e")
    let badgeText     = Color(hex: "#fde68a")

    let textPrimary   = Color(hex: "#fef3c7")
    let textSecondary = Color(hex: "#fde68a")
    let textMuted     = Color(hex: "#9a7c4c")
    let textDim       = Color(hex: "#6b5a3a")

    let chipBackground   = Color(hex: "#1f1500")
    let surface          = Color(hex: "#1a0f00")
    let border           = Color(hex: "#f59e0b")
    let progressFill     = Color(hex: "#f59e0b")
    let authorAvatar     = Color(hex: "#451a03")
    let authorAvatarText = Color(hex: "#fbbf24")

    let heroBackground = Color(hex: "#1c0f00")
    let heroBlob1      = Color(hex: "#f59e0b")
    let heroBlob2      = Color(hex: "#fbbf24")
    let heroBlob3      = Color(hex: "#ef4444")

    let primaryButton       = Color(hex: "#f59e0b")
    let primaryButtonText   = Color(hex: "#0f0a00")
    let secondaryButton     = Color(hex: "#1f1500")
    let secondaryButtonText = Color(hex: "#fbbf24")
}

// MARK: Ocean Mist (light, blue-grey)
struct OceanMistTheme: AppTheme {
    let id = "ocean_mist"
    let displayName = "Ocean Mist"
    let isDark = false

    let background   = Color(hex: "#f0f4f8")
    let card         = Color(hex: "#ffffff")
    let divider      = Color(hex: "#dde3ea")

    let accent        = Color(hex: "#0369a1")
    let accentLight   = Color(hex: "#38bdf8")
    let accentPale    = Color(hex: "#bae6fd")
    let badge         = Color(hex: "#0369a1")
    let badgeText     = Color(hex: "#e0f2fe")

    let textPrimary   = Color(hex: "#0c1a28")
    let textSecondary = Color(hex: "#1e4976")
    let textMuted     = Color(hex: "#4a6680")
    let textDim       = Color(hex: "#8ca3b8")

    let chipBackground   = Color(hex: "#e2eaf2")
    let surface          = Color(hex: "#e0f2fe")
    let border           = Color(hex: "#0369a1")
    let progressFill     = Color(hex: "#0369a1")
    let authorAvatar     = Color(hex: "#bae6fd")
    let authorAvatarText = Color(hex: "#0369a1")

    let heroBackground = Color(hex: "#0c2a45")
    let heroBlob1      = Color(hex: "#0369a1")
    let heroBlob2      = Color(hex: "#38bdf8")
    let heroBlob3      = Color(hex: "#06b6d4")

    let primaryButton       = Color(hex: "#0369a1")
    let primaryButtonText   = Color.white
    let secondaryButton     = Color(hex: "#e2eaf2")
    let secondaryButtonText = Color(hex: "#0369a1")
}

// MARK: Forest Ink (dark green + mint)
struct ForestInkTheme: AppTheme {
    let id = "forest_ink"
    let displayName = "Forest Ink"
    let isDark = true

    let background    = Color(hex: "#030a05")
    let card          = Color(hex: "#0a150a")
    let divider       = Color(hex: "#0f1f0f")

    let accent        = Color(hex: "#16a34a")
    let accentLight   = Color(hex: "#4ade80")
    let accentPale    = Color(hex: "#bbf7d0")
    let badge         = Color(hex: "#14532d")
    let badgeText     = Color(hex: "#bbf7d0")

    let textPrimary   = Color(hex: "#dcfce7")
    let textSecondary = Color(hex: "#bbf7d0")
    let textMuted     = Color(hex: "#4a7c5a")
    let textDim       = Color(hex: "#2d5a3d")

    let chipBackground   = Color(hex: "#0f1f0f")
    let surface  = Color(hex: "#071209")
    let border      = Color(hex: "#16a34a")
    let progressFill     = Color(hex: "#16a34a")
    let authorAvatar     = Color(hex: "#14532d")
    let authorAvatarText = Color(hex: "#4ade80")

    let heroBackground = Color(hex: "#020804")
    let heroBlob1      = Color(hex: "#16a34a")
    let heroBlob2      = Color(hex: "#4ade80")
    let heroBlob3      = Color(hex: "#06b6d4")

    let primaryButton      = Color(hex: "#16a34a")
    let primaryButtonText  = Color.white
    let secondaryButton    = Color(hex: "#0f1f0f")
    let secondaryButtonText = Color(hex: "#4ade80")
}

// MARK: Rose Paper (warm light + blush)
struct RosePaperTheme: AppTheme {
    let id = "rose_paper"
    let displayName = "Rose Paper"
    let isDark = false

    let background    = Color(hex: "#fff7f5")
    let card          = Color(hex: "#ffffff")
    let divider      = Color(hex: "#f5ddd8")

    let accent        = Color(hex: "#e11d48")
    let accentLight   = Color(hex: "#fb7185")
    let accentPale    = Color(hex: "#fecdd3")
    let badge         = Color(hex: "#9f1239")
    let badgeText     = Color(hex: "#ffe4e6")

    let textPrimary   = Color(hex: "#1c0a0e")
    let textSecondary = Color(hex: "#6b1428")
    let textMuted     = Color(hex: "#7a4a52")
    let textDim       = Color(hex: "#b48a92")

    let chipBackground   = Color(hex: "#fce7ea")
    let surface  = Color(hex: "#fff1f2")
    let border      = Color(hex: "#e11d48")
    let progressFill     = Color(hex: "#e11d48")
    let authorAvatar     = Color(hex: "#fecdd3")
    let authorAvatarText = Color(hex: "#e11d48")

    let heroBackground = Color(hex: "#3b0718")
    let heroBlob1      = Color(hex: "#e11d48")
    let heroBlob2      = Color(hex: "#fb7185")
    let heroBlob3      = Color(hex: "#f472b6")

    let primaryButton      = Color(hex: "#e11d48")
    let primaryButtonText  = Color.white
    let secondaryButton    = Color(hex: "#fce7ea")
    let secondaryButtonText = Color(hex: "#e11d48")
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: - 3. Theme registry
// ─────────────────────────────────────────────────────────────────────────────

enum AppThemeID: String, CaseIterable {
    case violetNight = "violet_night"
    case emberDark   = "ember_dark"
    case oceanMist   = "ocean_mist"
    case forestInk   = "forest_ink"
    case rosePaper   = "rose_paper"

    var theme: any AppTheme {
        switch self {
        case .violetNight: return VioletNightTheme()
        case .emberDark:   return EmberDarkTheme()
        case .oceanMist:   return OceanMistTheme()
        case .forestInk:   return ForestInkTheme()
        case .rosePaper:   return RosePaperTheme()
        }
    }

    static func from(id: String) -> AppThemeID {
        AppThemeID(rawValue: id) ?? .violetNight
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: - 4. ThemeManager
// ─────────────────────────────────────────────────────────────────────────────

/// Owned at app root, injected via @EnvironmentObject.
/// Persists the user's theme choice across launches.
final class ThemeManager: ObservableObject {

    @Published private(set) var current: any AppTheme

    private let defaultsKey = "selectedThemeID"

    init() {
        let savedID = UserDefaults.standard.string(forKey: "selectedThemeID") ?? ""
        self.current = AppThemeID.from(id: savedID).theme
    }

    func setTheme(_ id: AppThemeID) {
        withAnimation(.easeInOut(duration: 0.35)) {
            current = id.theme
        }
        UserDefaults.standard.set(id.rawValue, forKey: defaultsKey)
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: - Helpers
// ─────────────────────────────────────────────────────────────────────────────

extension Color {
    /// Initialise from a #RRGGBB or #RGB hex string.
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .init(charactersIn: "#"))
        let int = UInt64(hex, radix: 16) ?? 0
        let r, g, b: Double
        if hex.count == 6 {
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8)  & 0xFF) / 255
            b = Double(int         & 0xFF) / 255
        } else {
            r = Double((int >> 8) & 0xF) / 15
            g = Double((int >> 4) & 0xF) / 15
            b = Double(int        & 0xF) / 15
        }
        self.init(red: r, green: g, blue: b)
    }
    
    static var theme: AppTheme {
        let savedID = UserDefaults.standard.string(forKey: "selectedThemeID") ?? ""
        return AppThemeID.from(id: savedID).theme
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// MARK: - Set of colors
// ─────────────────────────────────────────────────────────────────────────────

extension Color {
    static let darkPurple = Color(hex: "#392776")
    static let lightPurple = Color(hex: "##7fa3ff")
    static let darkPink = Color(hex: "#2c032e")
    static let lightPink = Color(hex: "#e97eed")
    static let darkGreen = Color(hex: "#056b11")
    static let lightGreen = Color(hex: "#86f093")
    static let darkBlue = Color(hex: "#0f2275")
    static let lightBlue = Color(hex: "#8a9df2")
    static let darkRed = Color(hex: "#222222")
    static let lightRed = Color(hex: "#f54c4c")
    static let darkOrange = Color(hex: "#D85A30")
    static let lightOrange    = Color(hex: "#F0997B")
}
