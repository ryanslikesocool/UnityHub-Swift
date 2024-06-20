import SwiftUI
import UnityHubCommon

public struct ListItem<Content: View>: View {
	public typealias ContentProvider = () -> Content

	private let content: ContentProvider

	public init(@ViewBuilder content: @escaping ContentProvider) {
		self.content = content
	}

	public var body: some View {
		HStack {
			content()
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
