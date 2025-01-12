import SwiftUI
import UnityHubCommonViews
import UnityHubStorageSettings

/// ## Topics
/// ### Styles
/// - ``SidebarStyle``
/// - ``AnySidebarStyle``
/// - ``CompactSidebarStyle``
/// - ``DefaultSidebarStyle``
struct Sidebar: View {
	typealias Configuration = SidebarStyleConfiguration

	@Environment(\.sidebarStyle) private var style

	@AppSetting(general: \.sidebarDisplay) private var sidebarDisplay

	@Binding var selection: SidebarItem

	var body: some View {
		let configuration = Configuration(
			selection: $selection,
			links: [
				SidebarLink(.projects),
				SidebarLink(.installations),
				SidebarLink(.resources),
			]
		)

		NavigationStack {
			List(selection: configuration.selection) {
				style.makeBody(configuration: configuration)
			}
		}
		.listStyle(Self.listStyle)
		.scrollDisabled(Self.scrollDisabled)
		.safeAreaInset(edge: .bottom) {
			makeUserMenu()
				.frame(alignment: .leading)
		}
//		.overlay(alignment: .bottomLeading, content: makeUserMenu)
	}
}

// MARK: - Constants

private extension Sidebar {
	static let sidebarThreshold: CGFloat
		= (SidebarDisplay.standard.width + SidebarDisplay.compact.width) * 0.5

	static let listStyle: some ListStyle = .sidebar
	static let scrollDisabled: Bool = true

	static let userMenuButtonStyle: some PrimitiveButtonStyle = .borderless
	static let userMenuControlSize: ControlSize = .small
	static let userMenuLabelStyle: some LabelStyle = .iconOnly
	static let userMenuPadding: CGFloat = 8
}

// MARK: - Supporting Views

private extension Sidebar {
	func makeUserMenu() -> some View {
		UserMenu()
			.buttonStyle(Self.userMenuButtonStyle)
			.labelStyle(Self.userMenuLabelStyle)
			.controlSize(Self.userMenuControlSize)
//			.menuIndicator(.visible)
			.fixedSize()
			.padding(Self.userMenuPadding)
	}
}