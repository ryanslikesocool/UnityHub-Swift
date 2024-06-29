import SwiftUI

public struct ListItemURLLabelStyle: URLLabelStyle {
	public typealias Configuration = URLLabelStyleConfiguration
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.monospaced()
			.lineLimit(1)
			.font(.caption)
			.foregroundStyle(.tertiary)
	}
}

public extension ViewStyle<URLLabelStyleConfiguration> where Self == ListItemURLLabelStyle {
	static var listItem: Self { Self() }
}
