import SwiftUI

struct ProfileView: View {
    @Environment(\.theme) private var theme
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss
    @State private var showThemePicker = false
    
    //TODO: Move all data to VM
    @State private var followedTopics: [ArticleCategory] = [
        .painting, .digitalArt, .exhibitions, .artMarket, .photography
    ]

    private let readingBreakdown: [(category: ArticleCategory, pct: Double)] = [
        (.painting,    0.72),
        (.digitalArt,  0.54),
        (.exhibitions, 0.38),
        (.artMarket,   0.21),
    ]
        
    private let userName = "Anna Laurent"
    private let initials = "AL"
    private let userContacts = "@annalaurent · Paris, FR"
    private let userInfo = "Art writer & collector. Obsessed with contemporary painting, digital art, and the places where they collide."

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: Spacing.zero) {

                // MARK: Header Bar
                
                HStack {
                    Text(Strings.Profile.profile)
                        .font(.system(size: 26, weight: .bold))
                        .tracking(-0.5)
                       .foregroundColor(theme.textPrimary)
                    
                    Spacer()
                    
                    CircleIconButton(icon: AppIcons.squareAndArrowUp)
                    CircleIconButton(icon: AppIcons.gearshapeFill)
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.md)

                // MARK: Hero Banner
                
                ZStack(alignment: .bottomLeading) {
                    AbstractArtView(
                        category: .painting,
                        size: CGSize(width: screenWidth, height: 130)
                    )
                    .frame(height: 130)

                    LinearGradient(
                        colors: [.clear, theme.accent],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: Radius.zero))
                .padding(.top, Padding.md)

                // MARK: Avatar + Edit
                
                HStack(alignment: .bottom) {
                    // Avatar
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(colors: [theme.textPrimary, theme.accent],
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .frame(width: 76, height: 76)

                        Circle()
                            .fill(theme.surface)
                            .frame(width: 70, height: 70)

                        Text(initials)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(theme.textPrimary)
                    }
                    .offset(y: -30)

                    Spacer()

                    // Edit button
                    HStack(spacing: Spacing.xs) {
                        AppIcons.pencil
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(theme.primaryButton)
                        Text(Strings.Profile.editProfile)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(theme.textPrimary)
                    }
                    .padding(.horizontal, Padding.lg)
                    .padding(.vertical, Padding.sm)
                    .background(theme.accentLight)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.xxl)
                            .stroke(Color(hex: "#333333"), lineWidth: 0.5)
                    )
                    .clipShape(Capsule())
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, -Padding.xl)

                // MARK: User Info
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(userName)
                        .font(.system(size: 20, weight: .bold))
                       .foregroundColor(theme.textPrimary)

                    Text(userContacts)
                        .font(.system(size: 13))
                        .foregroundColor(theme.textMuted)

                    Text(userInfo)
                        .font(.system(size: 13))
                        .foregroundColor(theme.textSecondary)
                        .lineSpacing(3)
                        .padding(.top, Padding.xs)
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.xs)

                // MARK: Stats
                
                // TODO: Fetch digit values from VM
                
                HStack(spacing: Spacing.sm) {
                    StatCard(value: "347", label: Strings.Profile.articlesRead)
                    StatCard(value: "27",  label: Strings.Profile.saved)
                    StatCard(value: "12",  label: Strings.Profile.artistsFollowed)
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.lg)

                // MARK: Followed Topics
                
                SectionHeader(title: Strings.Profile.followedTopics, actionTitle: Strings.Profile.manage)

                PillsLayout(spacing: Spacing.sm) {
                    ForEach(followedTopics, id: \.self) { topic in
                        HStack(spacing: Spacing.xs) {
                            topic.icon
                                .font(.system(size: 12))
                            Text(topic.name)
                                .font(.system(size: 12, weight: .bold))
                        }
                       .foregroundColor(theme.textPrimary)
                        .padding(.horizontal, Padding.md)
                        .padding(.vertical, Padding.xs)
                        .background(topic.bgColor)
                        .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, Padding.lg)

                // MARK: Reading Breakdown
                
                SectionHeader(title: Strings.Profile.readingBreakdown)

                VStack(spacing: Spacing.zero) {
                    ForEach(readingBreakdown, id: \.category) { item in
                        ReadingBar(category: item.category, percentage: item.pct)
                        if item.category != readingBreakdown.last?.category {
                            Divider().background(theme.divider)
                        }
                    }
                }
                .background(theme.card)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.lg)
                        .stroke(theme.border, lineWidth: 0.5)
                )
                .padding(.horizontal, Padding.lg)

                // MARK: Account Menu
                
                SectionHeader(title: Strings.Profile.account)

                VStack(spacing: Spacing.zero) {
                    MenuRow(
                        icon: AppIcons.bellFill,
                        iconBg: Color(hex: "#1e1869"),
                        iconColor: theme.primaryButton,
                        label: Strings.Profile.notificationPreferences
                    )
                    
                    Divider().background(theme.divider)
                    
                    MenuRow(
                        icon: AppIcons.paintpalette,
                        iconBg: Color(hex: "#0d2010"),
                        iconColor: Color.lightGreen,
                        label: Strings.Profile.theme,
                        trailing: theme.displayName
                    )
                    .sheet(isPresented: $showThemePicker) {
                        ThemePickerView()
                    }
                    .onTapGesture {
                        showThemePicker = true
                    }
                    .animation(.easeInOut(duration: 0.35), value: themeManager.current.id)
                    
                    Divider().background(theme.divider)
                    
                    MenuRow(
                        icon: AppIcons.globe,
                        iconBg: Color.darkOrange,
                        iconColor: Color.lightOrange,
                        label: Strings.Profile.languageAndRegion,
                        trailing: Strings.Profile.english
                    )
                    
                    Divider().background(theme.divider)
                    
                    MenuRow(
                        icon: AppIcons.rectanglePortraitAndArrowRight,
                        iconBg: Color(hex: "#1a0808"),
                        iconColor: Color.darkRed,
                        label: Strings.Profile.signOut
                    )
                }
                .background(theme.card)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.lg)
                        .stroke(theme.border, lineWidth: 0.5)
                )
                .padding(.horizontal, Padding.lg)
                .padding(.bottom, Padding.lg)
            }
        }
        .background(theme.background)
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
