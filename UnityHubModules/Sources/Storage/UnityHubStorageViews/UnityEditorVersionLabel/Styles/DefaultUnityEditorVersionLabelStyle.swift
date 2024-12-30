import SwiftUI

public struct DefaultUnityEditorVersionLabelStyle: UnityEditorVersionLabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		let version = configuration.version

		HStack(spacing: 2) {
			(
				Text(version.semantic.description)
					+ Text("\(version.channel.description)\(version.iteration)")
					.foregroundStyle(.tertiary)
			)
			.monospaced()
			configuration.badge
		}
	}
}

// MARK: - Convenience

public extension UnityEditorVersionLabelStyle where
	Self == DefaultUnityEditorVersionLabelStyle
{
	static var `default`: Self {
		Self()
	}
}
