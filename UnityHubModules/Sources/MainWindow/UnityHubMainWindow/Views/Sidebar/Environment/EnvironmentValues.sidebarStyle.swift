import SwiftUI
import UnityHubCommonViews

extension EnvironmentValues {
	@Entry
	fileprivate(set) var sidebarStyle: AnySidebarStyle
		= AnySidebarStyle(.default)
}

// MARK: - Convenience

extension View {
	func sidebarStyle(_ style: some SidebarStyle) -> some View {
		environment(\.sidebarStyle, AnySidebarStyle(style))
	}
}
