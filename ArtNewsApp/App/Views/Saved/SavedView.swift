import SwiftUI

// MARK: - Saved View

struct SavedView: View {
    @Environment(\.theme) private var theme
    @State private var selectedTab: SavedTab = .articles
    @StateObject var viewModel: NewsViewModel
    
    private let collections = SampleData.collections // TODO: Are collections needed?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: Spacing.zero) {

                // MARK: Header
                
                HStack {
                    Text(Strings.Saved.saved)
                        .font(.system(size: 26, weight: .bold))
                        .tracking(-0.5)
                       .foregroundColor(theme.textPrimary)
                    
                    Spacer()
                    
                    CircleIconButton(icon: AppIcons.magnifyingglass)
                    
                    CircleIconButton(icon: AppIcons.ellipsis)
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.md)

                // MARK: Segmented Control
                
                HStack(spacing: Spacing.zero) {
                    ForEach(SavedTab.allCases, id: \.self) { tab in
                        Text(tab.rawValue)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(selectedTab == tab ? .white : theme.textMuted)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, Padding.sm)
                            .background(
                                selectedTab == tab
                                ? theme.accent
                                : theme.chipBackground
                            )
                            .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
                            .onTapGesture { selectedTab = tab }
                    }
                }
                .padding(Padding.xxs)
                .background(theme.chipBackground)
                .clipShape(RoundedRectangle(cornerRadius: Radius.md))
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.lg)

                // MARK: Collections Row
                
                SectionHeader(title: Strings.Saved.myCollections) {}
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.md) {
                        ForEach(collections) { collection in
                            CollectionCard(
                                collection: collection,
                                category: collection.category
                            )
                        }
                        
                        NewCollectionCard()
                    }
                    .padding(.horizontal, Padding.lg)
                }

                // MARK: All Saved
                
                HStack {
                    Text(Strings.Saved.allSaved)
                        .font(.system(size: 17, weight: .bold))
                       .foregroundColor(theme.textPrimary)
                    
                    Spacer()
                    
                    Text(Strings.Saved.artcilesRead(viewModel.favorites.count))
                        .font(.system(size: 12))
                        .foregroundColor(theme.textMuted)
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.xl)
                .padding(.bottom, Padding.sm)

                VStack(spacing: Spacing.zero) {
                    ForEach(Array(viewModel.favorites.enumerated()), id: \.element.id) { idx, article in
                        SavedArticleRow(
                            article: article,
                            detail: ArticleDetailView(article: article, viewModel: viewModel)
                        ) {
                            viewModel.toggleFavorite(article)
                        }
                        .padding(.horizontal, Padding.lg)
                        
                        if idx < viewModel.favorites.count - 1 {
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

#Preview {
    SavedView(viewModel: NewsViewModel(repository: NewsRepositoryMock()))
        .preferredColorScheme(.dark)
}
