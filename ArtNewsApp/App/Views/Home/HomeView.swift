import SwiftUI

struct HomeView: View {
    @Environment(\.theme) private var theme
    @StateObject var viewModel: NewsViewModel
    @State private var selectedCategory: ArticleCategory = .all
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: Spacing.zero) {
                HeaderView()
                    .padding(.horizontal, Padding.lg)
                    .padding(.top, Padding.md)
                    .padding(.bottom, Padding.sm)

                CategoryFiltersView()
                    .padding(.bottom, Padding.xs)
                    .refreshable {
                        await viewModel.loadNews()
                    }
                    .onAppear {
                        viewModel.fetchNews()
                        viewModel.loadFavorites()
                    }

                // MARK: Featured Card
                
                if let featuredArticle = viewModel.featuredArticle {
                    FeaturedArticleCard(
                        article: featuredArticle,
                        detail: ArticleDetailView(
                            article: featuredArticle,
                            viewModel: viewModel
                        )
                    )
                    .padding(.top, Padding.md)
                }
            
                // MARK: Trending
                
                SectionHeader(
                    title: Strings.Home.trendingNow,
                    actionTitle: Strings.Home.seeAll
                )

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.md) {
                        ForEach(viewModel.trendingArticles) { article in
                            SmallArticleCard(
                                article: article,
                                detail: ArticleDetailView(article: article, viewModel: viewModel)
                            )
                        }
                    }
                    .padding(.horizontal, Padding.lg)
                }

                // MARK: Latest
                
                SectionHeader(
                    title: Strings.Home.latestStories,
                    actionTitle: Strings.Home.seeAll
                )

                VStack(spacing: Spacing.zero) {
                    ForEach(Array(viewModel.latestArticles.enumerated()), id: \.element.id) { idx, article in
                        ArticleListRow(
                            article: article,
                            detail: ArticleDetailView(
                                article: article,
                                viewModel: viewModel
                            )
                        )
                        .padding(.horizontal, Padding.lg)
                        
                        if idx < viewModel.latestArticles.count - 1 {
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
    HomeView(
        viewModel: NewsViewModel(repository: NewsRepositoryMock())
    )
    .preferredColorScheme(.dark)
}
