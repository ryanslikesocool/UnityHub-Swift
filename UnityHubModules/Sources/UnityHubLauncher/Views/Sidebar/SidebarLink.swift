import SwiftUI

struct SidebarLink: View {
	private let item: SidebarItem

	init(_ item: SidebarItem) {
		self.item = item
	}

	var body: some View {
		NavigationLink(value: item) {
			Label(item.description, systemImage: item.systemImageName)
		}
	}
}
