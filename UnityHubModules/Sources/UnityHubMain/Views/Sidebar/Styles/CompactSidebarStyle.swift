import SwiftUI
import UnityHubCommonViews

struct CompactSidebarStyle: SidebarStyle {
	typealias Configuration = SidebarStyleConfiguration

	func makeBody(configuration: SidebarStyleConfiguration) -> some View {
		NavigationStack {
			List(selection: configuration.selection) {
				Group {
					ForEach(configuration.links.indices, id: \.self) { index in
						configuration.links[index]
					}

					Divider()

					configuration.userMenu
						.buttonStyle(.plain)
				}
				.frame(width: 59)
			}
			.labelStyle(.compactSidebar)
		}
	}
}

extension ViewStyle where Self == CompactSidebarStyle {
	static var compact: Self { Self() }
}
