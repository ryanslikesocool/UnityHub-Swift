import SwiftUI

public struct TextTrailingIconLabelStyle: LabelStyle {
	public func makeBody(configuration: Configuration) -> some View {
		HStack(spacing: 2) {
			configuration.title
			configuration.icon
		}
	}
}

public extension LabelStyle where Self == TextTrailingIconLabelStyle {
	static var textTrailingIcon: Self { Self() }
}
