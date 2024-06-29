import SwiftUI
import UnityHubCommonViews

typealias AnySidebarStyle = _AnyViewStyle<SidebarStyleConfiguration>

extension EnvironmentValues {
	fileprivate(set) var sidebarStyle: AnySidebarStyle {
		get { self[__Key_sidebarStyle.self] }
		set { self[__Key_sidebarStyle.self] = newValue }
	}

	private enum __Key_sidebarStyle: EnvironmentKey {
		static let defaultValue = AnySidebarStyle(.default)
	}
}

extension View {
	func sidebarStyle(_ style: some SidebarStyle) -> some View {
		environment(\.sidebarStyle, AnySidebarStyle(style))
	}

	func sidebarStyle(_ style: AnySidebarStyle) -> some View {
		environment(\.sidebarStyle, style)
	}
}
