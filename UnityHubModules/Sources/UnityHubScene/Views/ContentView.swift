import SwiftUI

struct ContentView: View {
	@State private var columnVisibility: NavigationSplitViewVisibility = .all
	@State private var sidebarSelection: SidebarItem = .projects

	var body: some View {
		NavigationSplitView(
			columnVisibility: $columnVisibility,
			sidebar: { Sidebar(selection: $sidebarSelection) },
			detail: { Detail(sidebarSelection: $sidebarSelection) }
		)
		.navigationSplitViewStyle(.prominentDetail)
		.onChange(of: columnVisibility) {
			DispatchQueue.main.async {
				columnVisibility = .all
			}
		}
	}
}
