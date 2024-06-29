import SwiftUI
import UnityHubCommonViews

struct DefaultSidebarStyle: SidebarStyle {
	typealias Configuration = SidebarStyleConfiguration

	func makeBody(configuration: SidebarStyleConfiguration) -> some View {
		NavigationStack {
			List(selection: configuration.selection) {
				ForEach(configuration.links.indices, id: \.self) { index in
					configuration.links[index]
				}
			}
		}
		.toolbar {
			ToolbarItem {
				configuration.userMenu
			}

			ToolbarItem.sidebarTrackingSeparator(placement: .navigation)
		}
	}
}

extension ViewStyle where Self == DefaultSidebarStyle {
	static var `default`: Self { Self() }
}
