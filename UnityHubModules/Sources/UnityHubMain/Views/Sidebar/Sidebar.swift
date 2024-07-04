import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

struct Sidebar: View {
	@Environment(\.sidebarStyle) private var style

	@AppSetting(general: \.sidebarDisplay) private var sidebarDisplay

	@Binding var selection: SidebarItem

	var body: some View {
//		GeometryReader { geometry in
			style.makeBody(
				configuration: SidebarStyleConfiguration(
					selection: $selection,
					links: [
						SidebarLink(item: .projects, label: Label.projects),
						SidebarLink(item: .installations, label: Label.installations),
						SidebarLink(item: .resources, label: Label.resources),
					],
					userMenu: UserMenu()
				)
			)
			.listStyle(.sidebar)
			.scrollDisabled(true)
//			.onChange(of: geometry.size) {
//				sidebarDisplay = if geometry.size.width < Self.sidebarThreshold {
//					.compact
//				} else {
//					.standard
//				}
//			}
//		}
	}
}

// MARK: - Constants

extension Sidebar {
	private static let sidebarThreshold: CGFloat = (SidebarDisplay.standard.width + SidebarDisplay.compact.width) * 0.5
}
