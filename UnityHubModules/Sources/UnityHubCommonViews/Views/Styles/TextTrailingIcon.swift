import SwiftUI

public struct TextTrailingIconLabelStyle: LabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		HStack(spacing: Self.spacing) {
			configuration.title
			configuration.icon
		}
	}
}

// MARK: - Constants

private extension TextTrailingIconLabelStyle {
	static let spacing: CGFloat? = 2
}

// MARK: - Convenience

public extension LabelStyle where
	Self == TextTrailingIconLabelStyle
{
	static var textTrailingIcon: Self {
		Self()
	}
}
