import SwiftUI
import UnityHubStorage

public struct UnityEditorVersionLabelStyleConfiguration {
	public let version: UnityEditorVersion
	public let badge: Badge

	@MainActor
	init(
		version: UnityEditorVersion,
		badge: some View
	) {
		self.version = version
		self.badge = Badge(badge)
	}
}

// MARK: - Supporting Data

public extension UnityEditorVersionLabelStyleConfiguration {
	/// The type-erased badge of a ``UnityEditorVersionLabel``.
	struct Badge: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}
}
