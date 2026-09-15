// CardImageView.swift
// ArtNewsApp
//
// Created by Mariia Shirokova on 11.06.2026.

import Foundation
import SwiftUI

struct ArticleImageView: View {
    let article: Article
    
    var body: some View {
        if let urlToImage = article.urlToImage {
            AsyncImage(url: URL(string: urlToImage)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    AbstractArtView(category: article.category,
                                    size: CGSize(width: screenWidth - 40, height: 220))
                        .frame(height: 220)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            //.clipped()
        }
    }
}
