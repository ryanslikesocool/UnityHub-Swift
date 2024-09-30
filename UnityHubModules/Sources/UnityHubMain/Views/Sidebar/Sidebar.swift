import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

struct Sidebar: View {
	typealias Configuration = SidebarStyleConfiguration

	@Environment(\.sidebarStyle) private var style

	@AppSetting(general: \.sidebarDisplay) private var sidebarDisplay

	@Binding var selection: SidebarItem

	var body: some View {
		let configuration = Configuration(
			selection: $selection,
			links: [
				SidebarLink(item: .projects, label: Label.projects),
				SidebarLink(item: .installations, label: Label.installations),
				SidebarLink(item: .resources, label: Label.resources),
			]
		)

		NavigationStack {
			List(selection: configuration.selection) {
				style.makeBody(configuration: configuration)
			}
		}
		.listStyle(.sidebar)
		.scrollDisabled(true)
		.overlay(alignment: .bottomLeading, content: makeUserMenu)
	}
}

// MARK: - Supporting Views

private extension Sidebar {
	func makeUserMenu() -> some View {
		UserMenu()
			.buttonStyle(.borderless)
			.controlSize(.small)
			.labelStyle(.iconOnly)
//					.menuIndicator(.visible)
			.fixedSize()
			.padding(8)
	}
}

// MARK: - Constants

extension Sidebar {
	private static let sidebarThreshold: CGFloat
		= (SidebarDisplay.standard.width + SidebarDisplay.compact.width) * 0.5
}
