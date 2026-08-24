// ArtTag.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 02.07.2026.

import Foundation

enum ArtTag: String, CaseIterable {
    case painting     = "#Painting"
    case abstraction  = "#Abstraction"
    case artMarket    = "#ArtMarket"
    case contemporary = "#Contemporary"
    case newYork      = "#NewYork"
    
    var name: String {
        switch self {
        case .painting:         return Strings.Common.Category.all
        case .abstraction:    return Strings.Common.Category.painting
        case .artMarket:   return Strings.Common.Category.sculpture
        case .contemporary:  return Strings.Common.Category.digitalArt
        case .newYork: return Strings.Common.Category.photography
        }
    }
}
