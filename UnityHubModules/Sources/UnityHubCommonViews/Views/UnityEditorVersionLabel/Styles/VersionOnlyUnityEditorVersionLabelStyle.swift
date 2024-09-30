import SwiftUI

public struct VersionOnlyUnityEditorVersionLabelStyle: UnityEditorVersionLabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		let version = configuration.version

		(
			Text(version.semantic.description)
				+ Text("\(version.channel.description)\(version.iteration)")
				.foregroundStyle(.tertiary)
		)
		.monospaced()
	}
}

// MARK: - Convenience

public extension UnityEditorVersionLabelStyle where
	Self == VersionOnlyUnityEditorVersionLabelStyle
{
	static var versionOnly: Self {
		Self()
	}
}
