import SwiftUI
import UnityHubCommon

public struct ListItem<Content, Menu, Issue>: View where
	Content: View,
	Menu: View,
	Issue: View
{
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
		HStack(spacing: Self.spacing) {
			content()
			menuButton
			issue()
		}
		.padding(Self.padding)
		.frame(minHeight: Self.height)
		.contentShape(Self.contentShape)
	}
}

// MARK: - Supporting Views

private extension ListItem {
	var menuButton: some View {
		SwiftUI.Menu(
			content: menu,
			label: menuLabel
		)
		.buttonStyle(Self.menuButtonStyle)
		.foregroundStyle(Self.menuButtonForegroundStyle)
		.menuIndicator(Self.menuIndicatorVisibility)
	}

	func menuLabel() -> some View {
		Label.menu()
			.labelStyle(Self.menuLabelStyle)
	}
}

// MARK: - Constants

private extension ListItem {
	static var height: CGFloat? { SmallMenuLabelStyle.height }
	static var spacing: CGFloat { 0 }
	static var padding: CGFloat { 4 }
	static var contentShape: some Shape { .rect }

	static var menuButtonStyle: some PrimitiveButtonStyle { .plain }
	static var menuButtonForegroundStyle: some ShapeStyle { .tertiary }
	static var menuIndicatorVisibility: Visibility { .hidden }
	static var menuLabelStyle: some LabelStyle { .smallMenu }
}
