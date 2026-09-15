// RelatedStory.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 02.07.2026.

import SwiftUI

// MARK: - Related Story

struct RelatedStory: Identifiable {
    let id = UUID()
    let category: String
    let categoryColor: Color
    let title: String
    let source: String
    let thumbBackground: Color
    let thumbAccent: Color
}
