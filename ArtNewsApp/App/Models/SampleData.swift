import SwiftUI

// MARK: - Sample Data

struct SampleData {
    static let article: Article = Article(
        title: "Kusama's Infinite Mirrors Tour Lands in Berlin",
        excerpt: "The immersive polka-dot world comes to the Gropius Bau this autumn.",
        content: "The immersive polka-dot world comes to the Gropius Bau this autumn.",
        category: .digitalArt, source: "Art Basel",
        author: "Wrong Times",
        timeAgo: "2h ago",
        readMinutes: 4,
        likes: 312,
        url: "https://kotaku.com/sega-drops-early-sonic-adventure-concept-art-2000692786",
        urlToImage: "https://en.artmediaagency.com/i/fd9b0a2e509ee2ab8989dcac4e18fc68/2048/",
        isBookmarked: false
    )
    
    static let articles: [Article] = [
        Article(title: "Kusama's Infinite Mirrors Tour Lands in Berlin",
                excerpt: "The immersive polka-dot world comes to the Gropius Bau this autumn.",
                content: "The immersive polka-dot world comes to the Gropius Bau this autumn.",
                category: .digitalArt, source: "Art Basel", author: "Wrong Times", timeAgo: "2h ago",
                readMinutes: 4, likes: 312, isBookmarked: false),
        Article(title: "Neo-Expressionism Returns to NYC Galleries",
                excerpt: "Raw mark-making is back and bigger than ever.",
                content: "Raw mark-making is back and bigger than ever.",
                category: .painting, source: "Artforum", author: "Wrong Times", timeAgo: "4h ago",
                readMinutes: 6, likes: 248, isBookmarked: true, isFeatured: false),
        Article(title: "AI Collaborations Redefine Creative Boundaries",
                excerpt: "How machine learning is reshaping the studio.",
                content: "How machine learning is reshaping the studio.",
                category: .digitalArt, source: "Wired Arts", author: "Wrong Times", timeAgo: "6h ago",
                readMinutes: 5, likes: 190, isFeatured: false),
        Article(title: "Hirst's New Bronze Series Stirs Controversy",
                excerpt: "Critics are divided on his latest monumental works.",
                content: "Critics are divided on his latest monumental works.",
                category: .sculpture, source: "The Guardian", author: "Wrong Times", timeAgo: "8h ago",
                readMinutes: 4, likes: 134, isFeatured: false),
        Article(title: "Cindy Sherman's New Self-Portraits Challenge Identity",
                excerpt: "The photographer turns the lens on digital selfhood.",
                content: "The photographer turns the lens on digital selfhood.",
                category: .photography, source: "Artforum", author: "Wrong Times", timeAgo: "12h ago",
                readMinutes: 7, likes: 205, isBookmarked: true, isFeatured: false),
        Article(title: "Louvre's Summer Pavilion Opens to Record Crowds",
                excerpt: "Over 40,000 visitors in the opening weekend.",
                content: "Over 40,000 visitors in the opening weekend.",
                category: .exhibitions, source: "The Art Newspaper", author: "Wrong Times", timeAgo: "1d ago",
                readMinutes: 3, likes: 178, isFeatured: false),
        Article(title: "Basquiat Canvas Shatters Records at Christie's",
                excerpt: "A stunning $110M hammer price rewrites the market.",
                content: "A stunning $110M hammer price rewrites the market.",
                category: .artMarket, source: "Bloomberg Arts", author: "Wrong Times", timeAgo: "2d ago",
                readMinutes: 5, likes: 421, isBookmarked: true, isFeatured: false),
    ]

    static let artists: [Artist] = [
        Artist(name: "Yayoi Kusama",   initials: "YK",
               gradientColors: [theme.textPrimary, theme.accentLight], isFollowing: true),
        Artist(name: "Kara Walker",    initials: "KW",
               gradientColors: [theme.heroBackground, theme.heroBackground], isFollowing: false),
        Artist(name: "Refik Anadol",   initials: "RA",
               gradientColors: [theme.accentLight, theme.textPrimary], isFollowing: true),
        Artist(name: "Cecily Brown",   initials: "CB",
               gradientColors: [theme.heroBackground, theme.heroBackground], isFollowing: false),
        Artist(name: "Jeff Koons",     initials: "JK",
               gradientColors: [theme.heroBackground, theme.heroBackground], isFollowing: false),
    ]

    static let trending: [TrendingItem] = [
        TrendingItem(rank: 1, title: "AI-generated works enter Venice Biennale shortlist",
                     category: .digitalArt, readCount: "4.2k", source: "Art Basel"),
        TrendingItem(rank: 2, title: "Tate Modern opens largest ever Basquiat retrospective",
                     category: .exhibitions, readCount: "3.8k", source: "The Guardian"),
        TrendingItem(rank: 3, title: "Record $220M sale puts Hockney among living legends",
                     category: .artMarket, readCount: "2.9k", source: "Christie's"),
        TrendingItem(rank: 4, title: "Serra's rusting giants find a new home in Oslo fjord",
                     category: .sculpture, readCount: "1.7k", source: "Art Newspaper"),
    ]

    static let collections: [ArticleCollection] = [
        ArticleCollection(name: "Favourites",  count: 14, accentColor: theme.textPrimary, category: .digitalArt),
        ArticleCollection(name: "Exhibitions", count: 8,  accentColor: theme.textDim, category: .exhibitions),
        ArticleCollection(name: "Art Market",  count: 5,  accentColor: theme.accent, category: .artMarket),
    ]

    static let notifications: [AppNotification] = [
        AppNotification(title: "Yayoi Kusama",
                        body: "published a new artist statement on her upcoming Seoul retrospective.",
                        type: .artistUpdate, timeAgo: "2m ago", isRead: false),
        AppNotification(title: "Tate Modern",
                        body: "just announced tickets for the Basquiat retrospective go on sale tomorrow at 9am.",
                        type: .exhibition, timeAgo: "18m ago", isRead: false),
        AppNotification(title: "Art Market",
                        body: "A new article matching your topic is trending — Hockney sale breaks European records.",
                        type: .trending, timeAgo: "1h ago", isRead: false),
        AppNotification(title: "Refik Anadol",
                        body: "added 3 new works to his portfolio — explore the latest generative pieces.",
                        type: .newWorks, timeAgo: "3h ago", isRead: false),
        AppNotification(title: "Art Digest",
                        body: "Your weekly digest is ready — 12 top stories from the past 7 days curated for you.",
                        type: .digest, timeAgo: "6h ago", isRead: false),
        AppNotification(title: "Kara Walker",
                        body: "is featured in a new group show opening at the Guggenheim Bilbao next month.",
                        type: .artistUpdate, timeAgo: "Yesterday", isRead: true),
        AppNotification(title: "Tracey Emin",
                        body: "A price record was set for a living sculptor at Christie's London — neon piece sold for £4.2M.",
                        type: .newWorks, timeAgo: "2 days ago", isRead: true),
    ]
    
    static let theme: AppTheme = {
        let savedID = UserDefaults.standard.string(forKey: "selectedThemeID") ?? ""
        return AppThemeID.from(id: savedID).theme
    }()
}
