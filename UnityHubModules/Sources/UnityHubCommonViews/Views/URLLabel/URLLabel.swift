import SwiftUI
import UnityHubCommon

public struct URLLabel: View {
	typealias Configuration = URLLabelStyleConfiguration

	@Environment(\.urlLabelStyle) private var style

	private let value: URL

	public init(_ value: URL) {
		self.value = value
	}

	public var body: some View {
		let text: String = value.abbreviatingWithTildeInPath
		let configuration = Configuration(
			label: Text(text)
				.help(text)
		)

		style.makeBody(configuration: configuration)
	}
}
