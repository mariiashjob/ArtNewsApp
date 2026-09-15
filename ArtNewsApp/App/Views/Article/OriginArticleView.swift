import SwiftUI
import WebKit

// MARK: - Origin Article Screen

struct OriginArticleView: View {
    let article: Article
    let showArtcile: (Bool) -> Void

    @State private var isLoading = true
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var webView: WKWebView?
    @State private var isLiked: Bool = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                if let url = article.url, let articleURL = URL(string: url) {
                    // Web content
                    WebViewWrapper(
                        url: articleURL,
                        pageTitle: article.source,
                        isLoading: $isLoading,
                        canGoBack: $canGoBack,
                        canGoForward: $canGoForward,
                        webViewRef: { wv in
                            DispatchQueue.main.async { webView = wv }
                        }
                    )
                    .ignoresSafeArea(edges: .bottom)
                }
                
                // Loading progress bar
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.linear)
                        .tint(.yellow)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.05))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 0.07, green: 0.07, blue: 0.07), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    // Back
                    NavIconButton(icon: AppIcons.arrowBackward) {
                        webView?.goBack()
                    }
                    .disabled(!canGoBack)
                    
                    // Forward
                    NavIconButton(icon: AppIcons.arrowForward) {
                        webView?.goForward()
                    }
                    .disabled(!canGoForward)
                }

                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // Refresh
                    NavIconButton(icon: AppIcons.arrowClockwise) {
                        if isLoading {
                            webView?.stopLoading()
                        } else {
                            webView?.reload()
                        }
                    }
                    
                    // Close
                    NavIconButton(icon: AppIcons.xmark) {
                        showArtcile(false)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

struct OriginArticleView_Previews: PreviewProvider {
    static var previews: some View {
        OriginArticleView(article: SampleData.article, showArtcile: { _ in
        })
    }
}
