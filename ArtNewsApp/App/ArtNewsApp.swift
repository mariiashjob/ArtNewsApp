//
//  ArtNewsAppApp.swift
//  ArtNewsApp
//
//  Created by user on 01.06.2026.
//

import SwiftUI

@main
struct ArtNewsApp: App {
    // Owned at the app root — lives for the entire session
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .withThemeManager(themeManager)
        }
    }
}
