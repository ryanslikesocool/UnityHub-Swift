import SwiftUI
import UnityHubCommon

public struct SmallMenuLabelStyle: LabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		configuration
			.icon
			.frame(width: Self.width, height: Constant.ListItem.height)
			.contentShape(.rect)
	}

	public static let width: CGFloat = 16
}

// MARK: - Convenience

public extension LabelStyle where
	Self == SmallMenuLabelStyle
{
	static var smallMenuStyle: Self {
		Self()
	}
}
