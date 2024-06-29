import SwiftUI
import UnityHubCommonViews

struct Sidebar: View {
	@Binding var selection: SidebarItem

	var body: some View {
		NavigationStack {
			List(selection: $selection) {
				SidebarLink(item: .projects, label: Label.projects)
				SidebarLink(item: .installations, label: Label.installations)
				SidebarLink(item: .resources, label: Label.resources)
			}
			.listStyle(.sidebar)
		}
		.toolbar {
			ToolbarItem {
				UserMenu()
			}
			ToolbarItem.sidebarTrackingSeparator(placement: .navigation)
		}
	}
}
