// Theme.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 03.07.2026.

import Foundation

enum Theme {
    case dark
    case light
    
    var name: String {
        switch self {
        case .dark: return Strings.Profile.dark
        case .light: return Strings.Profile.light
        }
    }
}
