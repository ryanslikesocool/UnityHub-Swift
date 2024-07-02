import SwiftUI
import UnityHubCommonViews

struct Sidebar: View {
	@Environment(\.sidebarStyle) private var style

	@AppSetting(general: \.compactSidebar) private var compactSidebar

	@Binding var selection: SidebarItem

	var body: some View {
		style.makeBody(
			configuration: SidebarStyleConfiguration(
				selection: $selection,
				links: [
					SidebarLink(item: .projects, label: Label.projects),
					SidebarLink(item: .installations, label: Label.installations),
					SidebarLink(item: .resources, label: Label.resources),
				],
				userMenu: UserMenu()
			)
		)
		.listStyle(.sidebar)
		.scrollDisabled(true)
		.contextMenu {
			Toggle("Compact", isOn: $compactSidebar)
		}
	}
}
