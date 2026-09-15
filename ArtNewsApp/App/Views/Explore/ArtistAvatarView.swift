// ArtistAvatarView.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 12.06.2026.

import SwiftUI

// MARK: - Artist Avatar

struct ArtistAvatarView: View {
    @Environment(\.theme) private var theme
    
    let artist: Artist

    var body: some View {
        VStack(spacing: Spacing.sm) {
            ZStack {
                Circle()
                    .fill(
                        artist.isFollowing
                        ? LinearGradient(colors: artist.gradientColors,
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing)
                        : LinearGradient(colors: [theme.background],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing)
                    )
                    .frame(width: 70, height: 70)

                // Avatar inner circle
                Circle()
                    .fill(theme.chipBackground)
                    .frame(width: 65, height: 65)

                Text(artist.initials)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(theme.textPrimary)
            }

            Text(artist.name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(theme.textPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 80)

            Text(artist.isFollowing ? Strings.Common.following : Strings.Common.follow)
                .font(.system(size: 11))
                .foregroundColor(artist.isFollowing ? theme.textPrimary : theme.textMuted)
        }
        .frame(width: 90)
    }
}

