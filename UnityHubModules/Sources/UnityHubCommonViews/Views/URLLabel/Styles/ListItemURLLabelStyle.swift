import SwiftUI

public struct ListItemURLLabelStyle: URLLabelStyle {
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.monospaced()
			.lineLimit(1)
			.font(.caption)
			.foregroundStyle(.tertiary)
	}
}

public extension URLLabelStyle where Self == ListItemURLLabelStyle {
	static var listItem: Self { Self() }
}
