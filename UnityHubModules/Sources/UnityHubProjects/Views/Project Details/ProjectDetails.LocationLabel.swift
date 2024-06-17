import SwiftUI

extension ProjectDetails {
	struct LocationLabel: View {
		private let url: URL

		init(_ url: URL) {
			self.url = url
		}

		var body: some View {
			LabeledContent("Location") {
				Text(url.abbreviatingWithTildeInPath)
					.monospaced()

				Button("Show in Finder", systemImage: "arrow.up.right", action: url.showInFinder)
					.help("Show in Finder")
					.controlSize(.small)
					.labelStyle(.iconOnly)
			}
		}
	}
}
