import SwiftUI

struct Sidebar: View {
	@Binding var selection: SidebarItem

	var body: some View {
		List(selection: $selection) {
			ForEach(SidebarItem.allCases) { item in
				SidebarLink(item)
			}
		}
		.toolbar(removing: .sidebarToggle)
		.toolbar {
			UserMenu()
		}
		.navigationSplitViewColumnWidth(160)
	}
}
