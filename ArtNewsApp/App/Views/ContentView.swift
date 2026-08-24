import SwiftUI

struct ContentView: View {
    @Environment(\.theme) private var theme
    @StateObject var viewModel: NewsViewModel
    @State private var selectedTab: AppTab = .home
    
    init() {
        let repository = Self.fetchNewsRepository()
        _viewModel = StateObject(wrappedValue: NewsViewModel(repository: repository))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView(viewModel: viewModel)
                    .tag(AppTab.home)
                
                ExploreView()
                    .tag(AppTab.explore)
                
                SavedView(viewModel: viewModel)
                    .tag(AppTab.saved)
                
                AlertsView()
                    .tag(AppTab.alerts)
                
                ProfileView()
                    .tag(AppTab.profile)
            }
            // Hide the native tab bar — we use our custom one
            .tabViewStyle(.page(indexDisplayMode: .never))

            ArtboardTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .background(theme.surface)
        .preferredColorScheme(.dark)
    }
    
    private static func fetchNewsRepository() -> NewsRepositoryProtocol {
        #if targetEnvironment(simulator)
            return NewsRepositoryMock()
        #else
        let service = NetworkService()
            let localStorage = LocalNewsStorage()
            let repository = NewsRepository(
                service: service,
                localStorage: localStorage
            )
        return repository
        #endif
    }
}

#Preview {
    ContentView()
}
