import SwiftUI

public struct LargeLabelStyle: LabelStyle {
	public func makeBody(configuration: Configuration) -> some View {
		VStack {
			configuration.icon
				.font(.largeTitle)
			configuration.title
				.font(.title3)
		}
		.foregroundStyle(.tertiary)
	}
}

public extension LabelStyle where Self == LargeLabelStyle {
	static var large: Self { Self() }
}
