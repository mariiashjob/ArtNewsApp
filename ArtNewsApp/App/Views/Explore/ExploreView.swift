import SwiftUI

struct ExploreView: View {
    @Environment(\.theme) private var theme
    @State private var searchText = ""
    
    private let topics = ArticleCategory.allCases.filter { $0 != .all }
    private let artists = SampleData.artists
    private let trending = SampleData.trending

    let topicArticleCounts: [ArticleCategory: String] = [
        .painting:    "1.2k",
        .sculpture:   "840",
        .digitalArt:  "2.4k",
        .photography: "980",
        .exhibitions: "3.1k",
        .artMarket:   "620",
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // MARK: Header
                
                HStack {
                    Text(Strings.Explore.explore)
                        .font(.system(size: 26, weight: .bold))
                        .tracking(-0.5)
                       .foregroundColor(theme.textPrimary)
                    
                    Spacer()
                    
                    CircleIconButton(icon: AppIcons.sliderHorizontal3)
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.md)

                // MARK: Search Bar
                
                HStack(spacing: Spacing.md) {
                    AppIcons.magnifyingglass
                        .foregroundColor(theme.textMuted)
                        .font(.system(size: 17))
                    
                    Text(Strings.Explore.searchText)
                        .font(.system(size: 14))
                        .foregroundColor(theme.textMuted)
                    
                    Spacer()
                    
                    AppIcons.micFill
                        .foregroundColor(theme.primaryButton)
                        .font(.system(size: 17))
                }
                .padding(.horizontal, Padding.md)
                .padding(.vertical, Padding.md)
                .background(theme.background)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.md)

                // MARK: Browse Topics
                
                SectionHeader(
                    title: Strings.Explore.browseTopics,
                    actionTitle: Strings.Explore.allTopics
                )

                let columns = [GridItem(.flexible(), spacing: Spacing.sm),
                               GridItem(.flexible(), spacing: Spacing.sm)]

                LazyVGrid(columns: columns, spacing: Spacing.sm) {
                    ForEach(topics, id: \.self) { topic in
                        TopicCard(
                            category: topic,
                            count: topicArticleCounts[topic] ?? String()
                        )
                    }
                }
                .padding(.horizontal, Padding.lg)

                // MARK: Featured Artists
                
                SectionHeader(
                    title: Strings.Explore.featuredArtists,
                    actionTitle: Strings.Explore.followMore
                )

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.md) {
                        ForEach(artists) { artist in
                            ArtistAvatarView(artist: artist)
                        }
                    }
                    .padding(.horizontal, Padding.lg)
                }

                // MARK: Trending This Week
                
                SectionHeader(title: Strings.Explore.trendingThisWeek)

                VStack(spacing: Spacing.zero) {
                    ForEach(Array(trending.enumerated()), id: \.element.id) { idx, item in
                        TrendingRow(item: item)
                            .padding(.horizontal, Padding.lg)
                        if idx < trending.count - 1 {
                            Divider()
                                .background(theme.divider)
                                .padding(.horizontal, Padding.lg)
                        }
                    }
                }
                .padding(.bottom, Padding.sm)
            }
        }
        .background(theme.background)
    }
}


// MARK: - Trending Row

private struct TrendingRow: View {
    @Environment(\.theme) private var theme
    
    let item: TrendingItem

    var body: some View {
        HStack(alignment: .center, spacing: Spacing.md) {
            Text(item.rank.description)
                .font(.system(size: 18, weight: .heavy))
                .foregroundColor(theme.textPrimary)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 3) {
                Text(item.category.name.uppercased())
                    .font(.system(size: 11, weight: .bold))
                    .tracking(0.5)
                    .foregroundColor(item.category.bgColor)

                Text(item.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(theme.textPrimary)
                    .lineLimit(1)

                Text(Strings.Explore.readsCount(item.readCount, source: item.source))
                    .font(.system(size: 11))
                    .foregroundColor(theme.textMuted)
            }

            Spacer()

            AbstractArtView(category: item.category, size: CGSize(width: 52, height: 52))
                .frame(width: 52, height: 52)
                .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
        }
        .padding(.vertical, Padding.md)
    }
}

#Preview {
    ExploreView()
        .preferredColorScheme(.dark)
}
