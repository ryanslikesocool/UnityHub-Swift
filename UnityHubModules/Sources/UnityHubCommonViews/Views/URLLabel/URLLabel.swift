import SwiftUI
import UnityHubCommon

public struct URLLabel: View {
	@Environment(\.urlLabelStyle) private var style

	private let value: URL

	public init(_ value: URL) {
		self.value = value
	}

	public var body: some View {
		let text: String = value.abbreviatingWithTildeInPath

		style.makeBody(configuration: URLLabelStyleConfiguration(
			label: URLLabelStyleConfiguration.Label(content:
				Text(text)
					.help(text)
			)
		))
	}
}
