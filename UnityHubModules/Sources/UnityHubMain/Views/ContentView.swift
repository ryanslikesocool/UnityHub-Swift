import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct ContentView: View {
	@AppSetting(general: \.compactSidebar) private var compactSidebar

	@State private var sidebarSelection: SidebarItem = .projects

	var body: some View {
		CustomSplitView(
			sidebar: {
				Sidebar(selection: $sidebarSelection)
			},
			detail: { Detail(sidebarSelection: $sidebarSelection) }
		)
		.ignoresSafeArea(.container, edges: .top)

		.sidebarStyle(compactSidebar ? AnySidebarStyle(.compact) : AnySidebarStyle(.default))

		.customSplitViewColumnWidth(.sidebar, compactSidebar ? 91 : 160)
		.customSplitViewColumnWidth(.default, min: 500)

		.errorReceiver(event: Event.locationError)
		.errorReceiver(event: Event.applicationError)
	}
}
