import SwiftUI

public struct DefaultUnityEditorVersionLabelStyle: UnityEditorVersionLabelStyle {
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

public extension UnityEditorVersionLabelStyle where Self == DefaultUnityEditorVersionLabelStyle {
	static var `default`: Self { Self() }
}
