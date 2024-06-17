import SwiftUI

struct Sidebar: View {
	@Binding var selection: SidebarItem

	private static let sidebarBreakpoint: CGFloat = 130

	var body: some View {
		// compact width = 96

//		GeometryReader { geometry in
		NavigationStack {
			List(selection: $selection) {
				ForEach(SidebarItem.allCases) { item in
					SidebarLink(item)
				}
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
