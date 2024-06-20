import SwiftUI
import UnityHubCommon

public struct ListItem<Content: View, Menu: View>: View {
	public typealias ContentProvider = () -> Content
	public typealias MenuProvider = () -> Menu

	private let content: ContentProvider
	private let menu: MenuProvider

	public init(
		@ViewBuilder content: @escaping ContentProvider,
		@ViewBuilder menu: @escaping MenuProvider
	) {
		self.content = content
		self.menu = menu
	}

	public var body: some View {
		HStack(spacing: 0) {
			content()

			SwiftUI.Menu(
				content: menu,
				label: {
					Label.menu()
						.frame(width: 16, height: Constant.ListItem.height)
						.contentShape(.rect)
				}
			)
			.buttonStyle(.plain)
			.foregroundStyle(.tertiary)
			.menuIndicator(.hidden)
			.labelStyle(.iconOnly)
		}
		.padding(4)
		.frame(minHeight: Constant.ListItem.height)
		.contentShape(.rect)
	}
}

// MARK: - Constants

public extension Constant {
	enum ListItem {
		public static let height: CGFloat = 32
	}
}
