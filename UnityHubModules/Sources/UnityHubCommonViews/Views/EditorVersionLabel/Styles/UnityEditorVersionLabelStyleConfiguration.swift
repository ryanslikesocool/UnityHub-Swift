import SwiftUI
import UnityHubStorage

public struct UnityEditorVersionLabelStyleConfiguration {
	/// The type-erased badge of a ``UnityEditorVersionLabel``.
	public struct Badge: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	public let version: UnityEditorVersion
	public let badge: Badge

	init(
		version: UnityEditorVersion,
		badge: some View
	) {
		self.version = version
		self.badge = Badge(content: badge)
	}
}
