// View+Extension.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 29.06.2026.

import Foundation
import SwiftUI

extension View {
    var screenWidth: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return 375 // Fallback safe size for iPhone 14/15/16 baseline models
        }
        if #available(iOS 26.0, *) {
            return windowScene.effectiveGeometry.coordinateSpace.bounds.width
        } else {
            return windowScene.windows.first?.bounds.width ?? UIScreen.main.bounds.width
        }
    }
}
