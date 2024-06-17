import SwiftUI

struct ContentView: View {
	@State private var sidebarSelection: SidebarItem = .projects

	var body: some View {
		CustomSplitView(
			sidebar: { Sidebar(selection: $sidebarSelection) },
			detail: { Detail(sidebarSelection: $sidebarSelection) }
		)
		.ignoresSafeArea(.container, edges: .top)
	}
}
