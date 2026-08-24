//
//  ThemeEnvironment.swift
//  ThemeSystem
//
//  Exposes the active theme as a SwiftUI Environment value so any view in the
//  hierarchy can reach it with just:
//
//      @Environment(\.theme) private var theme
//
//  without the view needing to declare an @EnvironmentObject<ThemeManager>
//  and unwrap .current every time — keeps individual views clean and decoupled
//  from the manager itself (they only need the value, not control over it).
//

import SwiftUI

// MARK: - Environment Key

private struct ThemeKey: EnvironmentKey {
    static let defaultValue: any AppTheme = VioletNightTheme()
}

extension EnvironmentValues {
    var theme: any AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// MARK: - Convenience modifier

/// Apply to the root view to wire ThemeManager → Environment in one call.
///
/// Usage in your App:
///
///     ContentView()
///         .withThemeManager(themeManager)
///
struct ThemeModifier: ViewModifier {
    @ObservedObject var manager: ThemeManager

    func body(content: Content) -> some View {
        content
            .environment(\.theme, manager.current)
            .preferredColorScheme(manager.current.colorScheme)
            .environmentObject(manager)
    }
}

extension View {
    func withThemeManager(_ manager: ThemeManager) -> some View {
        modifier(ThemeModifier(manager: manager))
    }
}
