// PrimaryButton.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 19.06.2026.

import Foundation
import SwiftUI

// MARK: - Primary Button

struct PrimaryButton: View {
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
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Padding.md)
            .background(Color.violetAccent)
            .cornerRadius(12)
        }
    }
}
