// NavIconButton.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 19.06.2026.

import Foundation
import SwiftUI

// MARK: - Nav Icon Button

struct NavIconButton: View {
    let icon: Image
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            icon
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.violetLight)
                .frame(width: 44, height: 44)
                .background(Color.tagBg)
                .cornerRadius(12)
        }
    }
}
