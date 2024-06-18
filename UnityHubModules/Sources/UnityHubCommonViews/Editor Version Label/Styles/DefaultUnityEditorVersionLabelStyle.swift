import SwiftUI

public struct DefaultUnityEditorVersionLabelStyle: UnityEditorVersionLabelStyle {
	public func makeBody(configuration: Configuration) -> some View {
		let version = configuration.version

		HStack {
			configuration.badge
			(
				Text(version.semantic.description)
					+ Text("\(version.channel.description)\(version.iteration)")
					.foregroundStyle(.tertiary)
			)
			.monospaced()
		}
	}
}

public extension UnityEditorVersionLabelStyle where Self == DefaultUnityEditorVersionLabelStyle {
	static var `default`: Self { Self() }
}
