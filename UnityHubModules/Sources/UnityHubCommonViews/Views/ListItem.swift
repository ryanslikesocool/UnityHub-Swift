import SwiftUI
import UnityHubCommon

public struct ListItem<Content: View, Menu: View, Issue: View>: View {
	public typealias ContentProvider = () -> Content
	public typealias MenuProvider = () -> Menu
	public typealias IssueProvider = () -> Issue

	private let content: ContentProvider
	private let menu: MenuProvider
	private let issue: IssueProvider

	public init(
		@ViewBuilder content: @escaping ContentProvider,
		@ViewBuilder menu: @escaping MenuProvider,
		@ViewBuilder issue: @escaping IssueProvider
	) {
		self.content = content
		self.menu = menu
		self.issue = issue
	}

	public var body: some View {
		HStack(spacing: 0) {
			content()
			menuButton
			issue()
		}
		.padding(4)
		.frame(minHeight: Constant.ListItem.height)
		.contentShape(.rect)
	}
}

// MARK: - Supporting Views

private extension ListItem {
	var menuButton: some View {
		SwiftUI.Menu(
			content: menu,
			label: menuLabel
		)
		.buttonStyle(.plain)
		.foregroundStyle(.tertiary)
		.menuIndicator(.hidden)
	}

	func menuLabel() -> some View {
		Label.menu()
			.labelStyle(.smallMenuStyle)
	}
}

// MARK: - Constants

public extension Constant {
	enum ListItem {
		public static let height: CGFloat = 32
	}
}
