import SwiftUI
import UnityHubCommonViews

struct Sidebar: View {
//	@State private var isCompact: Bool = false

	@Binding var selection: SidebarItem

//	private var sidebarWidth: CGFloat { isCompact ? 96 : 160 }
//	private static let sidebarBreakpoint: CGFloat = 130

	var body: some View {
//		GeometryReader { geometry in
		NavigationStack {
			List(selection: $selection) {
				SidebarLink(item: .projects, label: Label.projects)
				SidebarLink(item: .installations, label: Label.installations)
				SidebarLink(item: .resources, label: Label.resources)
			}
			.listStyle(.sidebar)
		}
//			.onChange(of: geometry.size.width) { oldValue, newValue in
//				if (oldValue ... newValue).contains(Self.sidebarBreakpoint) {
//					isCompact = newValue < Self.sidebarBreakpoint
//				}
//			}
//		}
		.toolbar {
			ToolbarItemGroup {
				UserMenu()
			}

			ToolbarItem(id: NSToolbarItem.Identifier.sidebarTrackingSeparator.rawValue, placement: .navigation, content: Divider.init)
		}
	}
}
