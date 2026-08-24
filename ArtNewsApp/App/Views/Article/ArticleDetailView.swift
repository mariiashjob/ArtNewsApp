//
//  ArticleDetailView.swift
//  ArtScreenDetail
//
//  A dark-mode article reader screen for an art-news app.
//  Recreated in SwiftUI from a Figma/HTML reference design.
//

import SwiftUI

// MARK: - Color Palette

extension Color {
    static let bgBlack        = Color(red: 0.039, green: 0.039, blue: 0.039) // #0a0a0a
    static let cardDark       = Color(red: 0.078, green: 0.078, blue: 0.078) // #141414
    static let hairline       = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
    static let hairlineLight  = Color(red: 0.118, green: 0.118, blue: 0.118) // #1e1e1e
    static let tagBg          = Color(red: 0.102, green: 0.102, blue: 0.102) // #1a1a1a
    static let quoteBg        = Color(red: 0.067, green: 0.031, blue: 0.125) // #110820
    static let heroBg         = Color(red: 0.071, green: 0.031, blue: 0.180) // #12082e
    static let violetAccent   = Color(red: 0.486, green: 0.227, blue: 0.929) // #7c3aed
    static let violetLight    = Color(red: 0.655, green: 0.545, blue: 0.980) // #a78bfa
    static let violetPale     = Color(red: 0.769, green: 0.722, blue: 1.0)   // #c4b8ff
    static let lavenderText   = Color(red: 0.878, green: 0.847, blue: 1.0)   // #e0d8ff
    static let mutedText      = Color(red: 0.533, green: 0.533, blue: 0.533) // #888 ish (body)
    static let dimText        = Color(red: 0.333, green: 0.333, blue: 0.333) // #555
    static let faintText      = Color(red: 0.267, green: 0.267, blue: 0.267) // #444
    static let fuchsiaAccent  = Color(red: 0.910, green: 0.475, blue: 0.976) // #e879f9
    static let emeraldAccent  = Color(red: 0.153, green: 0.682, blue: 0.376) // #27ae60
}

// MARK: - Article Detail View

struct ArticleDetailView: View {
    let article: Article
    
    @StateObject var viewModel: NewsViewModel
    @State private var scrollOffset: CGFloat = 0
    @State private var showArticle = false
    @State private var isSharing = false
    @Environment(\.dismiss) private var dismiss

    private let readingProgress: CGFloat = 0.35

    private let relatedStories: [RelatedStory] = [
        RelatedStory(
            category: "Exhibition",
            categoryColor: .emeraldAccent,
            title: "Tate Modern Opens Largest Ever Basquiat Retrospective",
            source: "The Guardian · 1d ago",
            thumbBackground: Color(red: 0.039, green: 0.082, blue: 0.039),
            thumbAccent: .emeraldAccent
        ),
        RelatedStory(
            category: "Art Market",
            categoryColor: .fuchsiaAccent,
            title: "Record $220M Sale Puts Hockney Among Living Legends",
            source: "Bloomberg Arts · 2d ago",
            thumbBackground: Color(red: 0.082, green: 0.031, blue: 0.094),
            thumbAccent: .fuchsiaAccent
        )
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.bgBlack.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: Spacing.zero) {
                    heroSection
                    progressBar
                    metaBar
                    articleContent
                    relatedSection
                }
                .padding(.bottom, Padding.bottomBar)
            }
            .ignoresSafeArea(edges: .top)

            bottomActionBar
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showArticle) {
            OriginArticleView(article: article) { value in
                showArticle = value
            }
        }
        .sheet(isPresented: $isSharing) {
            if let urlString = article.url, let url = URL(string: urlString) {
                ActivityView(activityItems: [article.title, url])
            }
        }
    }

    // MARK: Hero

    private var heroSection: some View {
        ZStack(alignment: .bottom) {
            ArticleImageView(article: article)

            LinearGradient(
                colors: [
                    Color.bgBlack.opacity(0.55),
                    Color.bgBlack.opacity(0.12),
                    Color.bgBlack.opacity(0.97)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 300)

            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                
                Text(article.category.name.uppercased())
                    .font(.system(size: 11, weight: .bold))
                    .tracking(0.5)
                    .foregroundColor(Color(red: 0.929, green: 0.914, blue: 0.992))
                    .padding(.horizontal, Padding.sm)
                    .padding(.vertical, Padding.xs)
                    .background(Color.violetAccent)
                    .cornerRadius(8)

                Text(article.title)
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(.white)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Padding.lg)
            .padding(.bottom, Padding.lg)

            // Top nav buttons
            VStack {
                HStack {
                    NavIconButton(icon: AppIcons.chevronLeft) {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    NavIconButton(icon: viewModel.isFavorite(article) ? AppIcons.bookmarkFill : AppIcons.bookmark) {
                        viewModel.toggleFavorite(article)
                    }
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.statusBar)
                Spacer()
            }
        }
        .frame(height: 300)
    }

    // MARK: Progress Bar

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Color(red: 0.102, green: 0.102, blue: 0.102)
                Color.violetAccent
                    .frame(width: geo.size.width * readingProgress)
            }
        }
        .frame(height: 2)
    }

    // MARK: Meta Bar

    private var metaBar: some View {
        HStack {
            if let initials = article.initials, let author = article.author {
                HStack(spacing: Spacing.md) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.176, green: 0.106, blue: 0.412)) // #2d1b69
                            .frame(width: 32, height: 32)
                        Text(initials)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.violetLight)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(author)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.lavenderText)
                        Text(article.source)
                            .font(.system(size: 11))
                            .foregroundColor(.dimText)
                    }
                }
            }
            
            Spacer()

            HStack(spacing: Spacing.lg) {
                HStack(spacing: Spacing.xs) {
                    AppIcons.clock
                        .font(.system(size: 12))
                    Text(article.readTime)
                        .font(.system(size: 12))
                }
                .foregroundColor(.dimText)

                HStack(spacing: Spacing.xs) {
                    AppIcons.heartFill
                        .font(.system(size: 12))
                        .foregroundColor(.violetAccent)
                    Text(article.likes.description)
                        .font(.system(size: 12))
                        .foregroundColor(.dimText)
                }
            }
        }
        .padding(.horizontal, Padding.lg)
        .padding(.vertical, Padding.md)
        .overlay(
            Rectangle()
                .fill(Color.hairline)
                .frame(height: 0.5),
            alignment: .bottom
        )
    }

    // MARK: Article Content

    private var articleContent: some View {
        VStack(alignment: .leading, spacing: Spacing.zero) {

            // Lead paragraph
            Text(article.excerpt ?? String())
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.violetLight)
                .lineSpacing(7)
                .padding(.bottom, Padding.lg)
                .overlay(
                    Rectangle()
                        .fill(Color.hairlineLight)
                        .frame(height: 0.5),
                    alignment: .bottom
                )
                .padding(.bottom, Padding.lg)

            bodyParagraph(plain: article.content)

            pullQuote(
                text: "\"The gesture is the fastest route from thought to surface. No software gets in between.\"",
                attribution: "— Mia Fontaine, painter, New York"
            )

            bodyParagraph(
                plain: "The movement — loosely termed Neo-Gestural Abstraction — has no manifesto and no formal membership. What unites it is a shared aesthetic vocabulary: ",
                emphasized: "thick, loaded impasto",
                trailing: ", emotionally charged colour, and a refusal of the polished finish that dominated the previous decade."
            )

            inlineArtwork

            Text("Installation view, \"Unfinished gestures,\" Pace Gallery New York, 2026")
                .font(.system(size: 12))
                .foregroundColor(.faintText)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.bottom, Padding.lg)

            bodyParagraph(
                plain: "Gallery programmes in New York, Berlin, and Seoul have responded with remarkable speed. At Pace New York, the recent group show ",
                emphasized: "\"Unfinished Gestures\"",
                trailing: " sold out its opening night, with prices ranging from $18,000 for smaller works to over $300,000 for large-scale canvases."
            )

            bodyParagraph(
                plain: "Critics are divided. Some see the movement as a genuine rupture with post-internet aesthetics; others worry it risks retreating into a romantic mythology of the artist's hand. What is undeniable is its market traction.",
                emphasized: nil,
                trailing: nil
            )

            tagsRow
        }
        .padding(.horizontal, Padding.lg)
        .padding(.top, Padding.lg)
    }

    private func bodyParagraph(plain: String, emphasized: String? = nil, trailing: String? = nil) -> some View {
        Group {
            if let emphasized, let trailing {
                Text(plain)
                    .foregroundColor(.mutedText)
                +
                Text(emphasized)
                    .foregroundColor(.violetPale)
                    .fontWeight(.semibold)
                +
                Text(trailing)
                    .foregroundColor(.mutedText)
            } else {
                Text(plain)
                    .foregroundColor(.mutedText)
            }
        }
        .font(.system(size: 14))
        .lineSpacing(Spacing.sm)
        .padding(.bottom, Padding.lg)
    }

    private func pullQuote(text: String, attribution: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(text)
                .font(.system(size: 15, weight: .semibold))
                .italic()
                .foregroundColor(.lavenderText)
                .lineSpacing(Spacing.xs)
            Text(attribution)
                .font(.system(size: 12))
                .foregroundColor(.dimText)
        }
        .padding(Padding.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.quoteBg)
        .overlay(
            Rectangle()
                .fill(Color.violetAccent)
                .frame(width: 3),
            alignment: .leading
        )
        .cornerRadius(12, corners: [.topRight, .bottomRight])
        .padding(.vertical, Padding.xs)
        .padding(.bottom, Padding.lg)
    }

    private var inlineArtwork: some View {
        InlineArtworkBackground()
            .frame(height: 160)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            .padding(.vertical, Padding.xs)
    }

    private var tagsRow: some View {
        let tags = ArtTag.allCases.map(\.rawValue)
        return FlowLayout(spacing: Spacing.sm) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.dimText)
                    .padding(.horizontal, Padding.md)
                    .padding(.vertical, Padding.sm)
                    .background(Color.tagBg)
                    .cornerRadius(20)
            }
        }
        .padding(.top, Padding.lg)
        .overlay(
            Rectangle()
                .fill(Color.tagBg)
                .frame(height: 0.5),
            alignment: .top
        )
    }

    // MARK: Related Section

    private var relatedSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(Strings.Artcile.relatedStories)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.xl)
                .padding(.bottom, Padding.sm)

            ForEach(relatedStories) { story in
                RelatedStoryCard(story: story)
                    .padding(.horizontal, Padding.lg)
                    .padding(.bottom, Padding.md)
            }
        }
    }

    // MARK: Bottom Bar
    
    private var bottomActionBar: some View {
        HStack(spacing: Spacing.md) {
            // Share button
            if article.url != nil {
                SecondaryButton(
                    buttonName: Strings.Artcile.share,
                    image: AppIcons.squareAndArrowUp
                ) {
                    isSharing = true
                }
            }
            
            // Full article button
            PrimaryButton(
                buttonName: Strings.Artcile.fullArticle,
                image: AppIcons.arrowUpForwardSquare
            ) {
                showArticle = true
            }
        }
        .padding(.horizontal, Padding.lg)
        .padding(.top, Padding.md)
        .padding(.bottom, Padding.sm)
        .background(
            Color.bgBlack.opacity(0.97)
                .overlay(
                    Rectangle()
                        .fill(Color.hairlineLight)
                        .frame(height: 0.5),
                    alignment: .top
                )
        )
    }
}

// MARK: - Related Story Card
private struct RelatedStoryCard: View {
    let story: RelatedStory

    var body: some View {
        HStack(spacing: Spacing.zero) {
            RelatedThumb(background: story.thumbBackground, accent: story.thumbAccent)
                .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 3) {
                Text(story.category.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .tracking(0.5)
                    .foregroundColor(story.categoryColor)
                Text(story.title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.lavenderText)
                    .lineSpacing(2)
                    .lineLimit(3)
                Spacer(minLength: 4)
                Text(story.source)
                    .font(.system(size: 11))
                    .foregroundColor(.faintText)
            }
            .padding(.horizontal, Padding.md)
            .padding(.vertical, Padding.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.cardDark)
        .overlay(
            RoundedRectangle(cornerRadius: Radius.lg)
                .stroke(Color(red: 0.133, green: 0.133, blue: 0.133), lineWidth: 0.5)
        )
        .cornerRadius(14)
    }
}

// MARK: - Decorative Backgrounds (stand-ins for the SVG artwork)
private struct HeroArtworkBackground: View {
    var body: some View {
        ZStack {
            Color.heroBg

            Circle()
                .fill(Color.violetAccent.opacity(0.2))
                .frame(width: 320, height: 320)
                .offset(x: -130, y: -110)

            Circle()
                .fill(Color.violetLight.opacity(0.12))
                .frame(width: 260, height: 260)
                .offset(x: 130, y: 70)

            Circle()
                .fill(Color.fuchsiaAccent.opacity(0.08))
                .frame(width: 200, height: 200)
                .offset(x: 150, y: -130)

            Ellipse()
                .strokeBorder(Color.violetLight.opacity(0.2), style: StrokeStyle(lineWidth: 1.5, dash: [10, 6]))
                .frame(width: 240, height: 120)

            Ellipse()
                .strokeBorder(Color.violetAccent.opacity(0.3), lineWidth: 1)
                .frame(width: 140, height: 70)

            Circle()
                .fill(Color.violetAccent.opacity(0.45))
                .frame(width: 28, height: 28)

            Circle()
                .fill(Color.violetLight.opacity(0.9))
                .frame(width: 12, height: 12)

            Group {
                Circle().fill(Color.fuchsiaAccent.opacity(0.5)).frame(width: 10, height: 10).offset(x: -82, y: -70)
                Circle().fill(Color.fuchsiaAccent.opacity(0.45)).frame(width: 10, height: 10).offset(x: 108, y: 75)
                Circle().fill(Color.violetLight.opacity(0.4)).frame(width: 8, height: 8).offset(x: 128, y: -60)
                Circle().fill(Color.violetLight.opacity(0.35)).frame(width: 8, height: 8).offset(x: -120, y: 70)
            }

            RoundedRectangle(cornerRadius: Radius.xxs)
                .fill(Color.violetAccent.opacity(0.15))
                .frame(width: 65, height: 45)
                .offset(x: 108, y: -82)

            RoundedRectangle(cornerRadius: Radius.xxs)
                .fill(Color.violetLight.opacity(0.1))
                .frame(width: 55, height: 38)
                .offset(x: -100, y: 70)
        }
    }
}

private struct InlineArtworkBackground: View {
    var body: some View {
        ZStack {
            Color(red: 0.051, green: 0.031, blue: 0.125) // #0d0820

            Circle()
                .fill(Color.violetAccent.opacity(0.22))
                .frame(width: 160, height: 160)
                .offset(x: -110, y: -50)

            Circle()
                .fill(Color.fuchsiaAccent.opacity(0.14))
                .frame(width: 140, height: 140)
                .offset(x: 110, y: 50)

            RoundedRectangle(cornerRadius: Radius.xxs)
                .fill(Color.violetAccent.opacity(0.2))
                .frame(width: 80, height: 120)
                .rotationEffect(.degrees(-5))
                .offset(x: -100, y: 0)

            RoundedRectangle(cornerRadius: Radius.xxs)
                .fill(Color.violetLight.opacity(0.15))
                .frame(width: 90, height: 130)
                .rotationEffect(.degrees(3))
                .offset(x: 0, y: -2)

            RoundedRectangle(cornerRadius: Radius.xxs)
                .fill(Color.fuchsiaAccent.opacity(0.18))
                .frame(width: 70, height: 110)
                .rotationEffect(.degrees(-2))
                .offset(x: 95, y: 5)

            Circle()
                .fill(Color.violetAccent.opacity(0.3))
                .frame(width: 40, height: 40)

            Circle()
                .fill(Color.violetLight.opacity(0.5))
                .frame(width: 16, height: 16)
        }
    }
}

private struct RelatedThumb: View {
    let background: Color
    let accent: Color

    var body: some View {
        ZStack {
            background

            Circle()
                .fill(accent.opacity(0.2))
                .frame(width: 90, height: 90)
                .offset(x: 25, y: -30)

            Circle()
                .strokeBorder(accent.opacity(0.4), style: StrokeStyle(lineWidth: 1.2, dash: [5, 3]))
                .frame(width: 36, height: 36)

            Circle()
                .fill(accent.opacity(0.35))
                .frame(width: 16, height: 16)

            Circle()
                .fill(accent.opacity(0.85))
                .frame(width: 6, height: 6)
        }
    }
}

// MARK: - Helpers

/// Rounds only specific corners of a view.
private extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

/// A very small flow layout for wrapping tag chips, similar to CSS flex-wrap.
struct FlowLayout: Layout {
    let spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        y += rowHeight
        return CGSize(width: maxWidth, height: y)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxWidth = bounds.width
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.minX + maxWidth, x > bounds.minX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), anchor: .topLeading, proposal: .unspecified)
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

// MARK: - Preview
struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(
            article: SampleData.article,
            viewModel: NewsViewModel(repository: NewsRepositoryMock())
        )
    }
}
