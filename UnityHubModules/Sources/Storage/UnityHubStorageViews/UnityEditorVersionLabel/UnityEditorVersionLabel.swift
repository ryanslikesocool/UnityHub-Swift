import SwiftUI
import UnityHubStorageInstallations

public struct UnityEditorVersionLabel: View {
	typealias Configuration = UnityEditorVersionLabelStyleConfiguration

	@Environment(\.unityEditorVersionLabelStyle) private var style

	private let value: UnityEditorVersion

	public init(_ value: UnityEditorVersion) {
		self.value = value
	}

	public var body: some View {
		let configuration = Configuration(
			version: value,
			badge: Badge(value)
		)

		style.makeBody(configuration: configuration)
	}
}
