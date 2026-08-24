// NewsViewModel.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 01.06.2026.

import Foundation
internal import Combine

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var favorites: [Article] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var isOffline = false
    
    private var repository: NewsRepositoryProtocol
    private var favoritesManager: FavoritesManagerProtocol
    
    private var currentPage = 1
    private var canLoadMore = true
    private var isLoadingMore = false
    
    var featuredArticle: Article? {
        articles.last(where: { $0.isFeatured }) ?? articles.last
    }

    var trendingArticles: [Article] {
        articles.filter { !$0.isFeatured }.prefix(3).map { $0 }
    }

    var latestArticles: [Article] {
        articles.sorted {
            $0.title < $1.title && $0.timeAgo < $1.timeAgo
        }
    }
    
    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
        self.favoritesManager = FavoritesManager()
    }
    
    func fetchNews() {
        Task {
            await loadNews()
        }
    }
    
    func loadNews() async {
        currentPage = 1
        canLoadMore = true

        isLoading = true
        errorMessage = nil
        isOffline = false

        do {
            let newArticles = try await repository.fetchNews(page: 1)

            articles = newArticles.map {
                Article(
                    title: $0.title,
                    excerpt: $0.description,
                    content: $0.content ?? "",
                    category: ArticleCategory.allCases.randomElement() ?? .all,
                    source: $0.source.name,
                    author: $0.author,
                    timeAgo: $0.publishedAt,
                    readMinutes: Int.random(in: 1...30),
                    likes: Int.random(in: 1...100),
                    url: $0.url,
                    urlToImage: $0.urlToImage
                    )
            }
            canLoadMore = !newArticles.isEmpty

        } catch {

            do {
                let cachedArticles = try repository.loadCachedNews()

                if cachedArticles.isEmpty {
                    errorMessage = "No internet connection and no cached news available."
                } else {
                    articles = cachedArticles
                    isOffline = true
                    canLoadMore = false
                }

            } catch {
                errorMessage = "Unable to load news."
            }
        }

        isLoading = false
    }
    
    func loadFavorites() {
        favorites = favoritesManager.loadFavorites()
    }
    
    func isFavorite(_ article: Article) -> Bool {
        favorites.contains(article)
    }
    
    func toggleFavorite(_ article: Article) {
        if isFavorite(article) {
            favorites.removeAll { $0 == article }
        } else {
            favorites.append(article)
        }
        
        saveFavorites()
    }
    
    func saveFavorites() {
        favoritesManager.saveFavorites(favorites)
    }
    
//    func loadMoreIfNeeded(currentItem: Article?) async {
//        guard let currentItem = currentItem else { return }
//        
//        let thresholdIndex = articles.index(articles.endIndex, offsetBy: -5)
//        
//        if articles.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
//            await loadMore()
//        }
//    }
    
//    func loadMore() async {
//        guard !isLoadingMore, canLoadMore else { return }
//        
//        isLoadingMore = true
//        currentPage += 1
//        
//        do {
//            let newArticles = try await repository.fetchNews(page: currentPage)
//            
//            articles.append(contentsOf: newArticles)
//            canLoadMore = !newArticles.isEmpty
//            
//        } catch {
//            errorMessage = "Failed to load more"
//        }
//        
//        isLoadingMore = false
//    }
}
