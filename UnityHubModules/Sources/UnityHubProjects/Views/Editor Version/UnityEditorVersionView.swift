import SwiftUI
import UnityHubStorage

public struct UnityEditorVersionView: View {
	private let value: UnityEditorVersion

	public init(_ value: UnityEditorVersion) {
		self.value = value
	}

	public var body: some View {
		HStack {
			UnityEditorVersionBadgeView(value)
			Text(value.description)
				.monospaced()
		}
	}
}
