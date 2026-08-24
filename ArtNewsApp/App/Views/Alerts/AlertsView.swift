import SwiftUI

struct AlertsView: View {
    @Environment(\.theme) private var theme
    @State private var notifications = SampleData.notifications

    var newNotifications: [AppNotification] { notifications.filter { !$0.isRead } }
    var earlierNotifications: [AppNotification] { notifications.filter { $0.isRead } }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // MARK: Header
                
                HStack {
                    Text(Strings.Alerts.alerts)
                        .font(.system(size: 26, weight: .bold))
                        .tracking(-0.5)
                        .foregroundColor(theme.textPrimary)
                    
                    Spacer()
                    
                    CircleIconButton(icon: AppIcons.gearshapeFill)

                    Text(newNotifications.count.description)
                        .font(.system(size: 13, weight: .bold))
                       .foregroundColor(theme.textPrimary)
                        .frame(width: 34, height: 34)
                        .background(theme.textDim)
                        .clipShape(Circle())
                }
                .padding(.horizontal, Padding.lg)
                .padding(.top, Padding.md)

                // MARK: New
                
                if !newNotifications.isEmpty {
                    HStack {
                        Text(Strings.Alerts.new)
                            .font(.system(size: 12, weight: .bold))
                            .tracking(0.8)
                            .foregroundColor(theme.textMuted)
                        
                        Spacer()
                        
                        Button {
                            markAllRead()
                        } label: {
                            Text(Strings.Alerts.markAllRead)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(theme.textPrimary)
                        }
                    }
                    .padding(.horizontal, Padding.lg)
                    .padding(.top, Padding.lg)
                    .padding(.bottom, Padding.sm)

                    VStack(spacing: Spacing.zero) {
                        ForEach(Array(newNotifications.enumerated()), id: \.element.id) { idx, notif in
                            NotificationRow(notification: notif, isUnread: true)
                            
                            if idx < newNotifications.count - 1 {
                                Divider()
                                    .background(theme.divider)
                                    .padding(.leading, Padding.lg + Padding.sm + Padding.md + Padding.statusBar
                                             + Padding.md)
                            }
                        }
                    }
                }

                // MARK: Earlier
                
                if !earlierNotifications.isEmpty {
                    Text(Strings.Alerts.earlier)
                        .font(.system(size: 12, weight: .bold))
                        .tracking(0.8)
                        .foregroundColor(theme.textMuted)
                        .padding(.horizontal, Padding.lg)
                        .padding(.top, Padding.xxl)
                        .padding(.bottom, Padding.sm)

                    VStack(spacing: Spacing.zero) {
                        ForEach(Array(earlierNotifications.enumerated()), id: \.element.id) { idx, notif in
                            NotificationRow(notification: notif, isUnread: false)
                            if idx < earlierNotifications.count - 1 {
                                Divider()
                                    .background(theme.divider)
                                    .padding(.leading, Padding.statusBar)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, Padding.sm)
        }
        .background(theme.background)
    }

    private func markAllRead() {
        for idx in notifications.indices {
            notifications[idx].isRead = true
        }
    }
}

#Preview {
    AlertsView()
        .preferredColorScheme(.dark)
}
