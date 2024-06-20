import SwiftUI
import UnityHubStorage

public struct UnityEditorVersionLabel: View {
	@Environment(\.unityEditorVersionLabelStyle) private var style

	private let value: UnityEditorVersion

	public init(_ value: UnityEditorVersion) {
		self.value = value
	}

	public var body: some View {
		style.makeBody(configuration: UnityEditorVersionLabelStyleConfiguration(
			version: value,
			badge: Badge(value)
		))
	}
}
