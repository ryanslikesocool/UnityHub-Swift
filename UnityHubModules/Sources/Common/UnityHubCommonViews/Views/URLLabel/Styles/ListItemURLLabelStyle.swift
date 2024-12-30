import SwiftUI

public struct ListItemURLLabelStyle: URLLabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.monospaced()
			.lineLimit(1)
			.font(.caption)
			.foregroundStyle(.tertiary)
	}
}

// MARK: - Convenience

public extension URLLabelStyle where
	Self == ListItemURLLabelStyle
{
	static var listItem: Self {
		Self()
	}
}
