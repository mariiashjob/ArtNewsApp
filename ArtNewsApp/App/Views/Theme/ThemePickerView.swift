//
//  ThemePickerView.swift
//  ThemeSystem
//
//  A full-screen theme picker that can be pushed or presented as a sheet.
//  Shows a live preview card for each theme so users know exactly what
//  they're choosing before confirming.
//

import SwiftUI

struct ThemePickerView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.theme) private var theme
    @Environment(\.dismiss) private var dismiss

    // Local selection while browsing — only committed on "Apply"
    @State private var selected: AppThemeID
    private let themes: [AppThemeID] = [.violetNight, .emberDark, .oceanMist, .rosePaper]

    init() {
        // Pre-select whatever is currently active
        let currentID = themes.first { $0.rawValue == (ThemeManager().current.id) } ?? .violetNight
        _selected = State(initialValue: currentID)
    }

    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()

            VStack(spacing: Spacing.zero) {
                header
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Spacing.xl) {
                        livePreviewCard
                        
                        swatchGrid
                        
                        applyButton
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                }
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: Header
    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(theme.textMuted)
                    .frame(width: 32, height: 32)
                    .background(theme.chipBackground)
                    .clipShape(Circle())
            }
            .accessibilityLabel("Close")

            Spacer()

            Text("Choose Theme")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(theme.textPrimary)

            Spacer()

            // Balance spacer so title stays centered
            Color.clear.frame(width: 32, height: 32)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .overlay(Rectangle().fill(theme.divider).frame(height: 0.5), alignment: .bottom)
    }

    // MARK: Live Preview Card
    // Shows a mini version of the article screen rendered with the *selected*
    // (not yet applied) theme, so the user sees a real preview.
    private var livePreviewCard: some View {
        let t = selected.theme
        return VStack(alignment: .leading, spacing: Spacing.zero) {

            // Mini hero
            ZStack(alignment: .bottomLeading) {
                MiniHeroBlobs(theme: t).frame(height: 100).clipped()
                LinearGradient(
                    colors: [t.heroBackground.opacity(0.3), t.heroBackground.opacity(0.9)],
                    startPoint: .top, endPoint: .bottom
                )
                .frame(height: 100)

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("PAINTING")
                        .font(.system(size: 9, weight: .bold))
                        .tracking(0.4)
                        .foregroundColor(t.badgeText)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(t.badge)
                        .cornerRadius(4)
                    Text("The Return of Gestural Abstraction")
                        .font(.system(size: 12, weight: .bold))
                       .foregroundColor(theme.textPrimary)
                        .lineLimit(2)
                }
                .padding(10)
            }
            .frame(height: 100)

            // Mini body
            VStack(alignment: .leading, spacing: Spacing.xs) {
                // Author row
                HStack(spacing: Spacing.xs) {
                    ZStack {
                        Circle().fill(t.authorAvatar).frame(width: 22, height: 22)
                        Text("SR").font(.system(size: 8, weight: .bold)).foregroundColor(t.authorAvatarText)
                    }
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Sarah Rowe").font(.system(size: 10, weight: .semibold)).foregroundColor(t.textPrimary)
                        Text("Artforum").font(.system(size: 8)).foregroundColor(t.textDim)
                    }
                    Spacer()
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "clock").font(.system(size: 8)).foregroundColor(t.textDim)
                        Text("6 min").font(.system(size: 8)).foregroundColor(t.textDim)
                    }
                }
                .padding(.horizontal, 10).padding(.top, 8)

                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        t.chipBackground.frame(maxWidth: .infinity)
                        t.progressFill.frame(width: geo.size.width * 0.35)
                    }
                }
                .frame(height: 2)

                // Lead text sample
                Text("From East Village studios to global auction houses, painters are abandoning digital restraint and embracing raw, physical mark-making.")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(t.accentLight)
                    .lineSpacing(2)
                    .lineLimit(2)
                    .padding(.horizontal, 10)

                // Pull quote sample
                HStack(spacing: Spacing.zero) {
                    t.border.frame(width: 2)
                    Text("\"The gesture is the fastest route.\"")
                        .font(.system(size: 8)).italic()
                        .foregroundColor(t.textPrimary)
                        .padding(.horizontal, 6).padding(.vertical, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(t.surface)
                }
                .cornerRadius(4, antialiased: true)
                .padding(.horizontal, 10)

                // Chip row
                HStack(spacing: Spacing.xxs) {
                    ForEach(["#Painting", "#Abstract"], id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 7, weight: .semibold))
                            .foregroundColor(t.textDim)
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(t.chipBackground)
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 10)

                // Mini bottom bar
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "bookmark")
                        .font(.system(size: 10))
                        .foregroundColor(t.secondaryButtonText)
                        .frame(width: 28, height: 24)
                        .background(t.secondaryButton)
                        .cornerRadius(6)
                    Text("Share")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(t.secondaryButtonText)
                        .frame(maxWidth: .infinity)
                        .frame(height: 24)
                        .background(t.secondaryButton)
                        .cornerRadius(6)
                    Text("Full article")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(t.primaryButtonText)
                        .frame(maxWidth: .infinity)
                        .frame(height: 24)
                        .background(t.primaryButton)
                        .cornerRadius(6)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .padding(.top, 4)
            }
            .background(t.background)
        }
        .background(t.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(t.accentLight.opacity(0.4), lineWidth: 1.5)
        )
        .shadow(color: t.accent.opacity(0.25), radius: 20, y: 8)
        .animation(.easeInOut(duration: 0.3), value: selected)
    }

    // MARK: Swatch Grid
    private var swatchGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Themes")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(theme.textDim)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(themes, id: \.rawValue) { id in
                    ThemeSwatchCard(
                        themeID: id,
                        isSelected: selected == id,
                        onTap: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selected = id
                            }
                        }
                    )
                }
            }
        }
    }

    // MARK: Apply Button
    private var applyButton: some View {
        Button {
            themeManager.setTheme(selected)
            dismiss()
        } label: {
            Text("Apply Theme")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(theme.primaryButtonText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(theme.primaryButton)
                .cornerRadius(14)
        }
        .accessibilityLabel("Apply \(selected.theme.displayName) theme")
    }
}

// MARK: - Theme Swatch Card

private struct ThemeSwatchCard: View {
    let themeID: AppThemeID
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        let t = themeID.theme
        Button(action: onTap) {
            VStack(spacing: Spacing.zero) {
                // Mini colour bar preview
                HStack(spacing: Spacing.zero) {
                    t.background .frame(maxWidth: .infinity, maxHeight: .infinity)
                    t.accent     .frame(maxWidth: .infinity, maxHeight: .infinity)
                    t.accentLight.frame(maxWidth: .infinity, maxHeight: .infinity)
                    t.card       .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 36)

                // Name + dark/light badge
                HStack {
                    Text(t.displayName)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(t.isDark ? .white : Color(hex: "#1a1a1a"))
                        .lineLimit(1)
                    Spacer()
                    Text(t.isDark ? "Dark" : "Light")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(t.isDark ? t.accentLight : t.accent)
                        .padding(.horizontal, 5).padding(.vertical, 2)
                        .background(t.chipBackground)
                        .cornerRadius(4)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(t.card)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? t.accent : Color.clear, lineWidth: 2.5)
            )
            .overlay(
                isSelected
                    ? Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(t.accent)
                        .padding(6)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Circle())
                        .padding(6)
                    : nil,
                alignment: .topTrailing
            )
            .shadow(color: isSelected ? t.accent.opacity(0.4) : .clear, radius: 8, y: 4)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(t.displayName) theme\(isSelected ? ", selected" : "")")
    }
}

// MARK: - Mini Hero Blobs (decorative)

private struct MiniHeroBlobs: View {
    let theme: any AppTheme
    var body: some View {
        ZStack {
            theme.heroBackground
            Circle().fill(theme.heroBlob1.opacity(0.35)).frame(width: 120).offset(x: -60, y: -40)
            Circle().fill(theme.heroBlob2.opacity(0.2)).frame(width: 100).offset(x: 100, y: 30)
            Circle().fill(theme.heroBlob3.opacity(0.15)).frame(width: 80).offset(x: 60, y: -50)
            Ellipse()
                .strokeBorder(theme.heroBlob2.opacity(0.25), style: StrokeStyle(lineWidth: 1, dash: [6, 4]))
                .frame(width: 160, height: 60)
            Circle().fill(theme.heroBlob1.opacity(0.6)).frame(width: 12)
            Circle().fill(theme.heroBlob2.opacity(0.9)).frame(width: 5)
        }
    }
}

// MARK: - Preview

#Preview {
    let manager = ThemeManager()
    return ThemePickerView()
        .withThemeManager(manager)
}
