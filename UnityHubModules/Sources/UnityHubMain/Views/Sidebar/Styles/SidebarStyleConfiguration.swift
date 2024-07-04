import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

struct SidebarStyleConfiguration: ViewStyleConfiguration {
	/// A type-erased navigation link of a ``Sidebar``.
	public struct NavigationLink: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	/// The type-erased user menu of a ``Sidebar``.
	public struct UserMenu: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	public let selection: Binding<SidebarItem>
	public let links: [NavigationLink]
	public let userMenu: UserMenu

	init(
		selection: Binding<SidebarItem>,
		links: [some View],
		userMenu: some View
	) {
		self.selection = selection
		self.links = links.map(NavigationLink.init)
		self.userMenu = UserMenu(content: userMenu)
	}
}
