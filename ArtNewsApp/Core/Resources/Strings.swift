// Strings.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 01.07.2026.

import Foundation

enum Strings {
    // MARK: Common
    
    enum Common {
        static let follow = String(localized: "follow")
        static let following = String(localized: "following")
        static let featured = String(localized: "featured")
        
        enum Menu {
            static let alerts = String(localized: "menu_alerts")
            static let explore = String(localized: "menu_explore")
            static let home = String(localized: "menu_home")
            static let profile = String(localized: "menu_profile")
            static let saved = String(localized: "menu_saved")
        }
        
        enum Category {
            static let all = String(localized: "category_all")
            static let artMarket = String(localized: "category_art_market")
            static let digitalArt = String(localized: "category_digital_art")
            static let exhibitions = String(localized: "category_exhibitions")
            static let painting = String(localized: "category_painting")
            static let photography = String(localized: "category_photography")
            static let sculpture = String(localized: "category_sculpture")
        }
        
        enum Tag {
            static let all = String(localized: "category_all")
            static let artMarket = String(localized: "category_art_market")
            static let digitalArt = String(localized: "category_digital_art")
            static let exhibitions = String(localized: "category_exhibitions")
            static let painting = String(localized: "category_painting")
        }
    }
    
    // MARK: Home screen
    
    enum Home {
        static let artboard = String(localized: "artboard")
        static let trendingNow = String(localized: "trending_now")
        static let seeAll = String(localized: "see_all")
        static let latestStories = String(localized: "latest_stories")
    }
    
    // MARK: Profile screen
    
    enum Profile {
        static let articlesRead = String(localized: "articles_read")
        static let profile = String(localized: "profile")
        static let editProfile = String(localized: "edit_profile")
        static let followedTopics = String(localized: "followed_topics")
        static let manage = String(localized: "manage")
        static let readingBreakdown = String(localized: "reading_breakdown")
        static let saved = String(localized: "saved")
        static let artistsFollowed = String(localized: "artists_followed")
        static let account = String(localized: "account")
        static let notificationPreferences = String(localized: "notification_preferences")
        static let dark = String(localized: "dark")
        static let light = String(localized: "light")
        static let appearance = String(localized: "appearance")
        static let languageAndRegion = String(localized: "language_and_region")
        static let english = String(localized: "English")
        static let signIn = String(localized: "sign_in")
        static let signOut = String(localized: "sign_out")
        static let theme = String(localized: "theme")
    }
    
    // MARK: Alerts screen
    
    enum Alerts {
        static let alerts = String(localized: "alerts")
        static let new = String(localized: "new")
        static let markAllRead = String(localized: "mark_all_read")
        static let earlier = String(localized: "earlier")
    }
    
    // MARK: Artcile Detail screen
    
    enum Artcile {
        static let relatedStories = String(localized: "related_stories")
        static let share = String(localized: "share")
        static let fullArticle = String(localized: "full_article")
        
        static func readingTime(_ time: String) -> LocalizedStringResource {
            return LocalizedStringResource("min", defaultValue: "\(time) min")
        }
        
    }
    
    // MARK: Explore screen
    
    enum Explore {
        static let explore = String(localized: "explore")
        static let searchText = String(localized: "search_text")
        static let browseTopics = String(localized: "browse_topics")
        static let allTopics = String(localized: "all_topics")
        static let featuredArtists = String(localized: "featured_artists")
        static let followMore = String(localized: "follow_more")
        static let trendingThisWeek = String(localized: "trending_this_week")
        
        static func readsCount(_ readCount: String, source: String) -> LocalizedStringResource {
            return LocalizedStringResource("reads", defaultValue: "\(readCount) reads · \(source)")
        }
    }
    
    // MARK: Saved screen
    
    enum Saved {
        static let newCollection = String(localized: "new_collection")
        static let offline = String(localized: "offline")
        static let saved = String(localized: "saved")
        static let myCollections = String(localized: "my_collections")
        static let allSaved = String(localized: "all_saved")

        static func artcilesRead(_ count: Int) -> LocalizedStringResource {
            return LocalizedStringResource("articles", defaultValue: "\(count) articles")
        }
        
        static func savedTime(_ timeAgo: String) -> LocalizedStringResource {
            return LocalizedStringResource("saved_time", defaultValue: "Saved \(timeAgo)")
        }
    }
    
    enum Notification {
        static let artistUpdate = String(localized: "artist_update")
        static let exhibition = String(localized: "exhibition")
        static let trending = String(localized: "trending")
        static let newWorks = String(localized: "new_works")
        static let weeklyDigest = String(localized: "weekly_digest")
    }
}
