import SwiftUI
import UnityHubCommon

public struct URLLabel: View {
	@Environment(\.urlLabelStyle) private var style

	private let value: URL

	public init(_ value: URL) {
		self.value = value
	}

	public var body: some View {
		style.makeBody(configuration: URLLabelStyleConfiguration(
			text: value.abbreviatingWithTildeInPath
		))
	}
}
