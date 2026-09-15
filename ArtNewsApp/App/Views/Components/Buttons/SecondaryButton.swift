// SecondaryButton.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 19.06.2026.

import Foundation
import SwiftUI

// MARK: - Secondary Button

struct SecondaryButton: View {
    let buttonName: String
    let image: Image?
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: Spacing.xs) {
                if let image {
                    image
                        .font(.system(size: 15))
                }
                
                Text(buttonName)
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundColor(.violetLight)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Padding.md)
            .background(Color.tagBg)
            .cornerRadius(12)
        }
    }
}
