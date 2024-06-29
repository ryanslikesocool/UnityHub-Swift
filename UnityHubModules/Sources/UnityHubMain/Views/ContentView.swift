import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct ContentView: View {
	@State private var sidebarSelection: SidebarItem = .projects

	var body: some View {
		CustomSplitView(
			sidebar: { Sidebar(selection: $sidebarSelection) },
			detail: { Detail(sidebarSelection: $sidebarSelection) }
		)
		.ignoresSafeArea(.container, edges: .top)
		.customSplitViewColumnWidth(.sidebar, 160)
		.customSplitViewColumnWidth(.detail, min: 500)

		.errorReceiver(event: Event.locationError)
		.errorReceiver(event: Event.applicationError)
	}
}
