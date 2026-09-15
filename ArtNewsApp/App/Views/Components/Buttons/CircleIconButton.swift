// CircleIconButton.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 11.06.2026.

import Foundation
import SwiftUI

// MARK: - Icon Button

struct CircleIconButton: View {
    @Environment(\.theme) private var theme
    let icon: Image
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            icon
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(theme.primaryButton)
                .frame(width: 34, height: 34)
                .background(theme.background)
                .clipShape(Circle())
        }
    }
}

#Preview {
    CircleIconButton(icon: AppIcons.gearshapeFill)
}
