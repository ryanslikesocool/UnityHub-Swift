import SwiftUI
import UnityHubCommonViews

struct CompactSidebarStyle: SidebarStyle {
	public init() { }

	public func makeBody(configuration: SidebarStyleConfiguration) -> some View {
		ForEach(configuration.links.indices, id: \.self) { index in
			configuration.links[index]
		}
		.frame(width: 59)
		.labelStyle(.compactSidebar)
	}
}

// MARK: - Convenience

extension SidebarStyle where
	Self == CompactSidebarStyle
{
	static var compact: Self {
		Self()
	}
}
