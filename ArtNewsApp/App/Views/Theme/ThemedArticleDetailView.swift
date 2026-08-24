//
//  ThemedArticleDetailView.swift
//  ThemeSystem
//
//  The article detail screen rebuilt to read every color from the active
//  theme via @Environment(\.theme).
//
//  Notice that:
//  • Views read `theme.accent`, `theme.textMuted`, etc — never hardcoded hex.
//  • Switching theme requires zero changes here; the system updates these
//    values automatically and SwiftUI re-renders.
//  • A "Theme" button in the nav bar opens ThemePickerView.
//

import SwiftUI

struct ThemedArticleDetailView: View {
    @Environment(\.theme) private var theme
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss
    @State private var showThemePicker = false

    var body: some View {
        ZStack(alignment: .bottom) {
            theme.background.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: Spacing.zero) {
                    ThemedHeroHeader(onBack: { dismiss() }, onTheme: { showThemePicker = true })
                    ThemedProgressBar()
                    ThemedMetaBar()
                    ThemedBodyContent()
                    ThemedRelatedSection()
                }
                .padding(.bottom, 90)
            }
            .ignoresSafeArea(edges: .top)

            ThemedBottomBar()
        }
        .sheet(isPresented: $showThemePicker) {
            ThemePickerView()
        }
        .animation(.easeInOut(duration: 0.35), value: themeManager.current.id)
    }
}

// MARK: - Hero

private struct ThemedHeroHeader: View {
    @Environment(\.theme) private var theme
    let onBack: () -> Void
    let onTheme: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            ThemedHeroBackground()
                .frame(height: 300).clipped()
                .accessibilityHidden(true)

            LinearGradient(
                colors: [theme.heroBackground.opacity(0.5), theme.heroBackground.opacity(0.05), theme.heroBackground.opacity(0.97)],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 300)
            .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                Text("PAINTING")
                    .font(.system(size: 11, weight: .bold)).tracking(0.5)
                    .foregroundColor(theme.badgeText)
                    .padding(.horizontal, 10).padding(.vertical, 4)
                    .background(theme.badge).cornerRadius(8)

                Text("The Return of Gestural Abstraction: How a New Generation is Reclaiming the Brush")
                    .font(.system(size: 21, weight: .bold))
                   .foregroundColor(theme.textPrimary).lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 16).padding(.bottom, 16)
            .accessibilityElement(children: .combine)

            // Nav
            VStack {
                HStack {
                    ThemedIconButton(systemName: "chevron.left", label: "Back", action: onBack)
                    Spacer()
                    HStack(spacing: Spacing.sm) {
                        ThemedIconButton(systemName: "paintpalette", label: "Change theme", action: onTheme)
                        ThemedIconButton(systemName: "square.and.arrow.up", label: "Share", action: {})
                        ThemedIconButton(systemName: "ellipsis", label: "More", action: {})
                    }
                }
                .padding(.horizontal, 16).padding(.top, 54)
                Spacer()
            }
        }
        .frame(height: 300)
    }
}

private struct ThemedIconButton: View {
    @Environment(\.theme) private var theme
    let systemName: String
    let label: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 15, weight: .semibold))
               .foregroundColor(theme.textPrimary)
                .frame(width: 34, height: 34)
                .background(Color.black.opacity(0.45))
                .clipShape(Circle())
        }
        .accessibilityLabel(label)
    }
}

// MARK: - Progress Bar

private struct ThemedProgressBar: View {
    @Environment(\.theme) private var theme
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                theme.chipBackground
                theme.progressFill.frame(width: geo.size.width * 0.35)
            }
        }
        .frame(height: 2)
        .accessibilityLabel("Reading progress, 35 percent")
    }
}

// MARK: - Meta Bar

private struct ThemedMetaBar: View {
    @Environment(\.theme) private var theme
    var body: some View {
        HStack {
            HStack(spacing: Spacing.md) {
                ZStack {
                    Circle().fill(theme.authorAvatar).frame(width: 32, height: 32)
                    Text("SR").font(.system(size: 11, weight: .bold)).foregroundColor(theme.authorAvatarText)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Sarah Rowe")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(theme.textPrimary)
                    Text("Artforum · Art Correspondent")
                        .font(.system(size: 11))
                        .foregroundColor(theme.textDim)
                }
            }
            Spacer()
            HStack(spacing: Spacing.lg) {
                Label("6 min", systemImage: "clock")
                    .font(.system(size: 12)).foregroundColor(theme.textDim)
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "heart.fill").font(.system(size: 12)).foregroundColor(theme.accent)
                    Text("248").font(.system(size: 12)).foregroundColor(theme.textDim)
                }
            }
        }
        .padding(.horizontal, 16).padding(.vertical, 14)
        .overlay(Rectangle().fill(theme.divider).frame(height: 0.5), alignment: .bottom)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Sarah Rowe, Artforum. 6 minute read, 248 likes")
    }
}

// MARK: - Body Content

private struct ThemedBodyContent: View {
    @Environment(\.theme) private var theme
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Lead
            Text("From East Village studios to global auction houses, painters are abandoning digital restraint and embracing raw, physical mark-making in ways that feel both urgent and deeply personal.")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(theme.accentLight)
                .lineSpacing(7)
                .padding(.bottom, 16)
                .overlay(Rectangle().fill(theme.divider).frame(height: 0.5), alignment: .bottom)
                .padding(.bottom, 16)

            // Body paragraph 1
            (Text("There is something almost defiant about picking up a paintbrush in 2026. In an era dominated by generative algorithms and frictionless digital tools, a growing cohort of artists is choosing ").foregroundColor(theme.textMuted)
            + Text("tactile, gestural painting").foregroundColor(theme.accentPale).fontWeight(.semibold)
            + Text(" — not as nostalgia, but as a deliberate act of resistance.").foregroundColor(theme.textMuted))
                .font(.system(size: 14)).lineSpacing(8).padding(.bottom, 14)

            // Pull quote
            HStack(spacing: Spacing.zero) {
                theme.border.frame(width: 3)
                VStack(alignment: .leading, spacing: 8) {
                    Text("\u{201C}The gesture is the fastest route from thought to surface. No software gets in between.\u{201D}")
                        .font(.system(size: 15, weight: .semibold)).italic()
                        .foregroundColor(theme.textPrimary).lineSpacing(5)
                    Text("— Mia Fontaine, painter, New York")
                        .font(.system(size: 12)).foregroundColor(theme.textDim)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(theme.surface)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.vertical, 4).padding(.bottom, 14)
            .accessibilityElement(children: .combine)

            // Body paragraph 2
            (Text("The movement — loosely termed Neo-Gestural Abstraction — has no manifesto and no formal membership. What unites it is a shared aesthetic vocabulary: ").foregroundColor(theme.textMuted)
            + Text("thick, loaded impasto").foregroundColor(theme.accentPale).fontWeight(.semibold)
            + Text(", emotionally charged colour, and a refusal of the polished finish that dominated the previous decade.").foregroundColor(theme.textMuted))
                .font(.system(size: 14)).lineSpacing(8).padding(.bottom, 14)

            // Inline image
            ThemedInlineArtwork()
                .frame(height: 160).frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .accessibilityLabel("Installation photograph")
            Text("Installation view, \"Unfinished gestures,\" Pace Gallery New York, 2026")
                .font(.system(size: 12)).foregroundColor(theme.textDim)
                .multilineTextAlignment(.center).frame(maxWidth: .infinity)
                .padding(.top, 4).padding(.bottom, 16)

            // Body paragraph 3
            (Text("Gallery programmes in New York, Berlin, and Seoul have responded with remarkable speed. At Pace New York, the recent group show ").foregroundColor(theme.textMuted)
            + Text("\"Unfinished Gestures\"").foregroundColor(theme.accentPale).fontWeight(.semibold)
            + Text(" sold out its opening night, with prices ranging from $18,000 for smaller works to over $300,000 for large-scale canvases.").foregroundColor(theme.textMuted))
                .font(.system(size: 14)).lineSpacing(8).padding(.bottom, 14)

            Text("Critics are divided. Some see the movement as a genuine rupture with post-internet aesthetics; others worry it risks retreating into a romantic mythology of the artist's hand. What is undeniable is its market traction.")
                .font(.system(size: 14)).foregroundColor(theme.textMuted).lineSpacing(8).padding(.bottom, 14)

            // Tags
            let tags = ["#Painting", "#Abstraction", "#ArtMarket", "#Contemporary", "#NewYork"]
            FlowLayout(spacing: Spacing.sm) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(theme.textDim)
                        .padding(.horizontal, 12).padding(.vertical, 6)
                        .background(theme.chipBackground)
                        .cornerRadius(20)
                }
            }
            .padding(.top, 16)
            .overlay(Rectangle().fill(theme.chipBackground).frame(height: 0.5), alignment: .top)
        }
        .padding(.horizontal, 16).padding(.top, 18)
    }
}

// MARK: - Related

private struct ThemedRelatedSection: View {
    @Environment(\.theme) private var theme

    private let stories: [(String, String, String, Bool)] = [
        ("Exhibition", "Tate Modern Opens Largest Ever Basquiat Retrospective", "The Guardian · 1d ago", true),
        ("Art Market", "Record $220M Sale Puts Hockney Among Living Legends", "Bloomberg Arts · 2d ago", false)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Related stories")
                .font(.system(size: 17, weight: .bold)).foregroundColor(theme.textPrimary)
                .padding(.horizontal, 16).padding(.top, 20).padding(.bottom, 10)

            ForEach(stories, id: \.1) { category, title, source, isFirst in
                HStack(spacing: Spacing.zero) {
                    ZStack {
                        (isFirst ? theme.heroBlob1 : theme.heroBlob3).opacity(0.12)
                        Circle().fill((isFirst ? theme.accent : theme.heroBlob3).opacity(0.25)).frame(width: 60)
                        Circle().fill((isFirst ? theme.accent : theme.heroBlob3).opacity(0.6)).frame(width: 16)
                        Circle().fill((isFirst ? theme.accentLight : theme.heroBlob3).opacity(0.9)).frame(width: 6)
                    }
                    .frame(width: 80, height: 80)
                    .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 3) {
                        Text(category.uppercased())
                            .font(.system(size: 10, weight: .bold)).tracking(0.5)
                            .foregroundColor(isFirst ? theme.accentLight : theme.heroBlob3)
                        Text(title)
                            .font(.system(size: 12, weight: .semibold)).foregroundColor(theme.textPrimary)
                            .lineSpacing(2).lineLimit(3)
                        Spacer(minLength: 4)
                        Text(source).font(.system(size: 11)).foregroundColor(theme.textDim)
                    }
                    .padding(.horizontal, 12).padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(theme.card)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(theme.divider, lineWidth: 0.5))
                .cornerRadius(14)
                .padding(.horizontal, 16).padding(.bottom, 12)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(category). \(title). \(source)")
            }
        }
    }
}

// MARK: - Bottom Bar

private struct ThemedBottomBar: View {
    @Environment(\.theme) private var theme
    @State private var bookmarked = false

    var body: some View {
        HStack(spacing: Spacing.md) {
            Button { bookmarked.toggle() } label: {
                Image(systemName: bookmarked ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 18)).foregroundColor(theme.secondaryButtonText)
                    .frame(width: 44, height: 44)
                    .background(theme.secondaryButton).cornerRadius(12)
            }
            .accessibilityLabel(bookmarked ? "Remove bookmark" : "Bookmark article")

            Button {} label: {
                Label("Share", systemImage: "square.and.arrow.up")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(theme.secondaryButtonText)
                    .frame(maxWidth: .infinity).padding(.vertical, 11)
                    .background(theme.secondaryButton).cornerRadius(12)
            }

            Button {} label: {
                Label("Full article", systemImage: "arrow.up.forward.square")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(theme.primaryButtonText)
                    .frame(maxWidth: .infinity).padding(.vertical, 11)
                    .background(theme.primaryButton).cornerRadius(12)
            }
        }
        .padding(.horizontal, 16).padding(.top, 12).padding(.bottom, 8)
        .background(
            theme.background.opacity(0.97)
                .overlay(Rectangle().fill(theme.divider).frame(height: 0.5), alignment: .top)
        )
    }
}

// MARK: - Decorative Backgrounds

private struct ThemedHeroBackground: View {
    @Environment(\.theme) private var theme
    var body: some View {
        ZStack {
            theme.heroBackground
            Circle().fill(theme.heroBlob1.opacity(0.22)).frame(width: 320).offset(x: -130, y: -110)
            Circle().fill(theme.heroBlob2.opacity(0.14)).frame(width: 260).offset(x: 130, y: 70)
            Circle().fill(theme.heroBlob3.opacity(0.10)).frame(width: 200).offset(x: 150, y: -130)
            Ellipse()
                .strokeBorder(theme.heroBlob2.opacity(0.2), style: StrokeStyle(lineWidth: 1.5, dash: [10, 6]))
                .frame(width: 240, height: 120)
            Ellipse().strokeBorder(theme.heroBlob1.opacity(0.3), lineWidth: 1).frame(width: 140, height: 70)
            Circle().fill(theme.heroBlob1.opacity(0.5)).frame(width: 28)
            Circle().fill(theme.heroBlob2.opacity(0.9)).frame(width: 12)
            Group {
                Circle().fill(theme.heroBlob3.opacity(0.5)).frame(width: 10).offset(x: -82, y: -70)
                Circle().fill(theme.heroBlob3.opacity(0.45)).frame(width: 10).offset(x: 108, y: 75)
                Circle().fill(theme.heroBlob2.opacity(0.4)).frame(width: 8).offset(x: 128, y: -60)
                Circle().fill(theme.heroBlob2.opacity(0.35)).frame(width: 8).offset(x: -120, y: 70)
            }
        }
    }
}

private struct ThemedInlineArtwork: View {
    @Environment(\.theme) private var theme
    var body: some View {
        ZStack {
            theme.heroBackground
            Circle().fill(theme.heroBlob1.opacity(0.22)).frame(width: 160).offset(x: -110, y: -50)
            Circle().fill(theme.heroBlob3.opacity(0.14)).frame(width: 140).offset(x: 110, y: 50)
            RoundedRectangle(cornerRadius: 4).fill(theme.heroBlob1.opacity(0.2)).frame(width: 80, height: 120).rotationEffect(.degrees(-5)).offset(x: -100)
            RoundedRectangle(cornerRadius: 4).fill(theme.heroBlob2.opacity(0.15)).frame(width: 90, height: 130).rotationEffect(.degrees(3))
            RoundedRectangle(cornerRadius: 4).fill(theme.heroBlob3.opacity(0.18)).frame(width: 70, height: 110).rotationEffect(.degrees(-2)).offset(x: 95, y: 5)
            Circle().fill(theme.accent.opacity(0.35)).frame(width: 40)
            Circle().fill(theme.accentLight.opacity(0.55)).frame(width: 16)
        }
    }
}

// MARK: - Preview

#Preview("Violet Night") {
    let manager = ThemeManager()
    return ThemedArticleDetailView()
        .withThemeManager(manager)
}

#Preview("Ember Dark") {
    let manager = ThemeManager()
    manager.setTheme(.emberDark)
    return ThemedArticleDetailView()
        .withThemeManager(manager)
}

#Preview("Ocean Mist") {
    let manager = ThemeManager()
    manager.setTheme(.oceanMist)
    return ThemedArticleDetailView()
        .withThemeManager(manager)
}
