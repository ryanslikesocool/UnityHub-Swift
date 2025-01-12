import SwiftUI
import UnityHubCommonViews

/// ## Topics
/// - ``SidebarStyle/default``
struct DefaultSidebarStyle: SidebarStyle {
	public init() { }

	public func makeBody(configuration: SidebarStyleConfiguration) -> some View {
		ForEach(configuration.links.indices, id: \.self) { index in
			configuration.links[index]
		}
	}
}

// MARK: - Convenience

extension SidebarStyle where
	Self == DefaultSidebarStyle
{
	static var `default`: Self {
		Self()
	}
}
