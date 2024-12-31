import SwiftUI
import UnityHubCommon

public struct SmallMenuLabelStyle: LabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		configuration
			.icon
			.frame(width: Self.width, height: Self.height)
			.contentShape(Self.contentShape)
	}
}

// MARK: - Constants

public extension SmallMenuLabelStyle {
	static let width: CGFloat = 16
	static let height: CGFloat = 32
	static let contentShape: some Shape = .rect
}

// MARK: - Convenience

public extension LabelStyle where
	Self == SmallMenuLabelStyle
{
	static var smallMenu: Self {
		Self()
	}
}