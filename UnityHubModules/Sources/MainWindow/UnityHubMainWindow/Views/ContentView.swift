import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageSettings

struct ContentView: View {
	@AppSetting(general: \.sidebarDisplay) private var sidebarDisplay

	@State private var sidebarSelection: SidebarItem = .projects

	var body: some View {
		CustomSplitView(
			sidebar: { Sidebar(selection: $sidebarSelection) },
			detail: { Detail(sidebarSelection: $sidebarSelection) }
		)
		.ignoresSafeArea(.container, edges: .top)

		.sidebarStyle(sidebarDisplay.viewStyle)

		.customSplitViewItemLayout(.sidebar, min: SidebarDisplay.compact.width, max: SidebarDisplay.standard.width, collapsible: false)
		.customSplitViewDefaultThickness(.sidebar, sidebarDisplay.width)
		.customSplitViewSnap(index: 0, enabled: true, onChange: onChangeSnapIndex)

		.customSplitViewItemLayout(.default, min: 500, collapsible: false)

		.errorReceiver(event: Event.locationError)
		.errorReceiver(event: Event.applicationError)
	}
}

// MARK: - Functions

private extension ContentView {
	func onChangeSnapIndex(index: Int) {
		sidebarDisplay = index == 0 ? .compact : .standard
	}
}
