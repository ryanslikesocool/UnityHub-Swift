import SwiftUI

public struct DefaultBadgeStyle: BadgeStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		configuration.content
			.opacity(0.75)
			.font(.caption.weight(.semibold))
			.padding(2.5)
			.background(configuration.fill.opacity(0.2), in: configuration.shape)
			.overlay(configuration.stroke.opacity(0.1), in: configuration.shape.stroke(lineWidth: 1))
			.textSelection(.disabled)
	}
}

// MARK: - Convenience

public extension BadgeStyle where
	Self == DefaultBadgeStyle
{
	static var `default`: Self {
		Self()
	}
}
