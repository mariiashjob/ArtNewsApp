// Article+Extension.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 04.06.2026.

import Foundation

// MARK: - Response Article Mock

extension ResponseArticle {
    static let mockArticles: [ResponseArticle] = [
        ResponseArticle(
            source: ResponseSource(id: nil, name: "Gizmodo.com"),
            author: "Tom Hawking",
            title: "Someone Created a Version of 'Elden Ring' That Runs on a PS1",
            description: "Well, thou art of passing skill.",
            url: "https://gizmodo.com/someone-created-a-version-of-elden-ring-that-runs-on-a-ps1-2000757141",
            urlToImage: "https://gizmodo.com/app/uploads/2026/05/elden-ring-ps1-1200x675.png",
            publishedAt: "2026-05-11T21:37:36Z",
            content: "A scruffy armored figure trudges up some stairs toward a heavy metal portal..."
        ),
        ResponseArticle(
            source: ResponseSource(id: nil, name: "Gizmodo.com"),
            author: "Matthew Phelan",
            title: "Researchers Confirm Oldest Cave Art in Britain a Century After It Was Dismissed as a Mineral Deposit",
            description: "New research places a once-dismissed piece of rock art back into the 'Stone Age' canon.",
            url: "https://gizmodo.com/researchers-confirm-oldest-cave-art-in-britain-2000765937",
            urlToImage: "https://gizmodo.com/app/uploads/2026/06/Bacon-Hole-Cave-Painting-D-Stretch-Filter-1200x675.jpg",
            publishedAt: "2026-06-01T20:20:56Z",
            content: "For nearly a century, skeptics dismissed a Paleolithic cave painting as merely rust-red iron oxides..."
        ),
        ResponseArticle(
            source: ResponseSource(id: "the-verge", name: "The Verge"),
            author: "Andrew Webster",
            title: "Hanging out in my favorite virtual coffee shop in Tokyo",
            description: "Finding a cafe that fits you can be a revelatory experience.",
            url: "https://www.theverge.com/entertainment/936278/coffee-talk-tokyo-review-switch-xbox-ps5-steam",
            urlToImage: "https://platform.theverge.com/wp-content/uploads/sites/2/2026/05/11.-Ayame-and-Fuku.jpg",
            publishedAt: "2026-05-22T17:16:55Z",
            content: "Coffee Talk Tokyo is a return to the cozy cafe series, with new faces but the same chill vibes."
        ),
        ResponseArticle(
            source: ResponseSource(id: nil, name: "Kotaku"),
            author: "Lewis Parker",
            title: "Neverness To Everness Accused Of Replacing GenAI Art With Different GenAI Art",
            description: "Eagle-eyed fans think the AI art on an in-game billboard has been swapped with an AI slop image of a soda can.",
            url: "https://kotaku.com/neverness-to-everness-ai-art-genai-billboard-2000694298",
            urlToImage: "https://kotaku.com/app/uploads/2026/05/Neverness-To-Everness-combined-artwork-1200x675.jpg",
            publishedAt: "2026-05-08T16:28:40Z",
            content: "Less than a day after the developers announced they would be reworking AI-generated images..."
        ),
        ResponseArticle(
            source: ResponseSource(id: "business-insider", name: "Business Insider"),
            author: "Anneta Konstantinides",
            title: "The 2026 Met Gala is hours away. Here's what to know ahead of fashion's biggest night.",
            description: "The 2026 Met Gala has a \"Costume Art\" theme and \"Fashion is Art\" dress code.",
            url: "https://www.businessinsider.com/met-gala-live-updates-red-carpet-arrivals-outfits-2026-5",
            urlToImage: "https://i.insider.com/69f8b7179a23d20d291b6038?width=1200&format=jpeg",
            publishedAt: "2026-05-04T17:02:01Z",
            content: "All across Manhattan, stars are powdering their noses, smoothing down wrinkles on gowns..."
        ),
        ResponseArticle(
            source: ResponseSource(id: nil, name: "NPR"),
            author: "Chloe Veltman",
            title: "Protests and boycotts rock prestigious Venice Biennale",
            description: "The 61st edition of the international art event launched in an atmosphere marked by geopolitical strife.",
            url: "https://www.npr.org/2026/05/09/nx-s1-5817005/protests-and-boycotts-rock-prestigious-venice-biennale",
            urlToImage: "https://npr.brightspotcdn.com/dims3/default/strip/false/crop/5796x3260+0+302/resize/1400/quality/85/format/jpeg/",
            publishedAt: "2026-05-10T01:41:40Z",
            content: "The 61st Venice Biennale opened Saturday in a chaotic atmosphere marked by geopolitical strife..."
        ),
        ResponseArticle(
            source: ResponseSource(id: nil, name: "Scientific American"),
            author: "Stephanie Pappas",
            title: "'Golden rule' in abstract art just discovered by mathematicians",
            description: "A mathematical ratio could explain why AI-generated art doesn't evoke awe from viewers.",
            url: "https://www.scientificamerican.com/article/golden-rule-in-abstract-art-just-discovered-by-mathematicians/",
            urlToImage: "https://static.scientificamerican.com/dam/asset/0ba1a2da-4bf6-4fea-98bd-98f82662876f/GettyImages-2206653685.jpeg",
            publishedAt: "2026-05-14T19:35:00Z",
            content: "Mathematicians have calculated a golden rule for abstract art that famous artists tend to follow..."
        ),
        ResponseArticle(
            source: ResponseSource(id: nil, name: "BBC News"),
            author: nil,
            title: "How did tattoo artists become legal in South Korea?",
            description: "The BBC is in Seoul, where tattooists have gathered to celebrate their art, following decades of underground work.",
            url: "https://www.bbc.com/news/videos/c9we0ln71llo",
            urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/42ae/live/8630d7e0-5ae3-11f1-8b8c-6d33e1d5abb6.jpg",
            publishedAt: "2026-05-30T10:35:31Z",
            content: "Tattoo artists have worked underground in South Korea for decades - until now..."
        ),
        ResponseArticle(
            source: ResponseSource(id: nil, name: "The New Yorker"),
            author: "Sudarsan Raghavan",
            title: "The Art of the Ceasefire",
            description: "How President Trump's approach to the war in Iran is turning endless conflict into the status quo.",
            url: "https://www.newyorker.com/news/the-lede/the-art-of-the-ceasefire",
            urlToImage: "https://media.newyorker.com/photos/6a024a95efa17d9af9093d8b/16:9/w_1280,c_limit/ArtoftheCeasefire_h_16464711.jpg",
            publishedAt: "2026-05-12T10:00:00Z",
            content: "Does this mean we are in an era of endless war, broken up by temporary ceasefires?..."
        ),
        ResponseArticle(
            source: ResponseSource(id: nil, name: "Kotaku"),
            author: "Zack Kotzer",
            title: "Sega Drops Early Sonic Adventure Concept Art That Shows An Entirely Different Vibe",
            description: "Millennium chic was not always the direction for Sonic's Dreamcast defining debut.",
            url: "https://kotaku.com/sega-drops-early-sonic-adventure-concept-art-2000692786",
            urlToImage: "https://kotaku.com/app/uploads/2026/05/sonicadventureconcept-1193x675.jpg",
            publishedAt: "2026-05-03T15:00:43Z",
            content: "The Sega Dreamcast's dramatic launch campaign left a distinct mark on the late 90s..."
        )
    ]
}


// MARK: - Convenience Extensions
 
extension ResponseArticle {
    /// Mock article
    static var mockArticle: ResponseArticle {
        ResponseArticle(
            source: ResponseSource(id: nil, name: "Kotaku"),
            author: "Zack Kotzer",
            title: "Sega Drops Early Sonic Adventure Concept Art That Shows An Entirely Different Vibe",
            description: "Millennium chic was not always the direction for Sonic's Dreamcast defining debut.",
            url: "https://kotaku.com/sega-drops-early-sonic-adventure-concept-art-2000692786",
            urlToImage: "https://en.artmediaagency.com/i/fd9b0a2e509ee2ab8989dcac4e18fc68/2048/",
            publishedAt: "2026-05-03T15:00:43Z",
            content: "The Sega Dreamcast's dramatic launch campaign left a distinct mark on the late 90s..."
        )
    }
    
    /// Articles grouped by source name
    static var mockBySource: [String: [ResponseArticle]] {
        Dictionary(grouping: mockArticles, by: { $0.source.name })
    }
 
    /// Articles with images only
    static var mockWithImages: [ResponseArticle] {
        mockArticles.filter { $0.urlToImage != nil }
    }
 
    /// Articles by a specific author
    static func mock(byAuthor name: String) -> [ResponseArticle] {
        mockArticles.filter { $0.author?.contains(name) == true }
    }
}
