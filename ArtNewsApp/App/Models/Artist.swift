// Artist.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 03.07.2026.

import SwiftUI

// MARK: - Artist

struct Artist: Identifiable {
    let id = UUID()
    let name: String
    let initials: String
    let gradientColors: [Color]
    var isFollowing: Bool
}
