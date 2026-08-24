// ArticleCategory.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 01.07.2026.

import SwiftUI

// MARK: - Category Modelc

enum ArticleCategory: CaseIterable, Codable, Equatable {
    case all
    case painting
    case sculpture
    case digitalArt
    case photography
    case exhibitions
    case artMarket
    
    var name: String {
        switch self {
        case .all:         return Strings.Common.Category.all
        case .painting:    return Strings.Common.Category.painting
        case .sculpture:   return Strings.Common.Category.sculpture
        case .digitalArt:  return Strings.Common.Category.digitalArt
        case .photography: return Strings.Common.Category.photography
        case .exhibitions: return Strings.Common.Category.exhibitions
        case .artMarket:   return Strings.Common.Category.artMarket
        }
    }
    
    var bgColor: Color {
        switch self {
        case .all:         return Color.darkBlue
        case .painting:    return Color.lightBlue
        case .sculpture:   return Color.lightPink
        case .digitalArt:  return Color.lightGreen
        case .photography: return Color.darkPurple
        case .exhibitions: return Color.lightBlue
        case .artMarket:   return Color.darkGreen
        }
    }
    
    var icon: Image {
        switch self {
        case .painting:    return AppIcons.paintpaletteFill
        case .digitalArt:  return AppIcons.desktopcomputer
        case .exhibitions: return AppIcons.buildingColumnsFill
        case .artMarket:   return AppIcons.chartLineUptrendXyaxis
        case .photography: return AppIcons.cameraFill
        default:           return AppIcons.starFill
        }
    }
}
