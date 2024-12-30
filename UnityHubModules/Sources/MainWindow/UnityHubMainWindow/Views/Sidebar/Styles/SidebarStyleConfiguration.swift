import SwiftUI
import UnityHubCommonViews
import UnityHubStorageSettings

struct SidebarStyleConfiguration {
	public let selection: Binding<SidebarItem>
	public let links: [NavigationLink]

	@MainActor
	init(
		selection: Binding<SidebarItem>,
		links: [some View]
	) {
		self.selection = selection
		self.links = links.map(NavigationLink.init)
	}
}

// MARK: - Supporting Data

extension SidebarStyleConfiguration {
	/// A type-erased navigation link of a ``Sidebar``.
	public struct NavigationLink: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}
}
