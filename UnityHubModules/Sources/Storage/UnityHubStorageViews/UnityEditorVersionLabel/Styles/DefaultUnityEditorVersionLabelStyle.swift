import SwiftUI

public struct DefaultUnityEditorVersionLabelStyle: UnityEditorVersionLabelStyle {
	private let badgeVisibility: Visibility

	public init(badge badgeVisibility: Visibility) {
		self.badgeVisibility = badgeVisibility
	}

	public func makeBody(configuration: Configuration) -> some View {
		let version = configuration.version

		let semanticVersion = Text(version.semantic.description)
		let channelText = Text("\(version.channel.description)\(version.iteration)")
			.foregroundStyle(Self.channelTextStyle)

		HStack(spacing: Self.spacing) {
			(semanticVersion + channelText)
				.monospaced()

			if case .visible = badgeVisibility {
				configuration.badge
			}
		}
	}
}

// MARK: - Constants

private extension DefaultUnityEditorVersionLabelStyle {
	static let spacing: CGFloat = 2
	static let channelTextStyle: some ShapeStyle = .tertiary
}

// MARK: - Convenience

public extension UnityEditorVersionLabelStyle where
	Self == DefaultUnityEditorVersionLabelStyle
{
	static var `default`: Self {
		Self(badge: .visible)
	}

	static func `default`(badge badgeVisibility: Visibility) -> Self {
		Self(badge: badgeVisibility)
	}
}
