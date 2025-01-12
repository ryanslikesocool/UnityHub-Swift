import SwiftUI

public struct LargeLabelStyle: LabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		VStack {
			configuration.icon
				.font(Self.iconFont)
			configuration.title
				.font(Self.titleFont)
		}
		.foregroundStyle(Self.foregroundStyle)
	}
}

// MARK: - Constants

private extension LargeLabelStyle {
	static var iconFont: Font { .largeTitle }
	static var titleFont: Font { .title3 }

	static var foregroundStyle: some ShapeStyle { .tertiary }
}

// MARK: - Convenience

public extension LabelStyle where
	Self == LargeLabelStyle
{
	static var large: Self {
		Self()
	}
}
