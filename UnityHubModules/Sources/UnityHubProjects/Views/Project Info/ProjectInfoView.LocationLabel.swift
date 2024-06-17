import SwiftUI

extension ProjectInfoView {
	struct LocationLabel: View {
		private let url: URL

		init(_ url: URL) {
			self.url = url
		}

		var body: some View {
			LabeledContent("Location") {
				HStack {
					Text(url.abbreviatingWithTildeInPath)
						.help(url.abbreviatingWithTildeInPath)
						.monospaced()
						.lineLimit(1)
						.textSelection(.disabled)
						.frame(maxWidth: 320)

					Button("Show in Finder", systemImage: "arrow.up.right", action: url.showInFinder)
						.help("Show in Finder")
						.controlSize(.small)
						.labelStyle(.iconOnly)
				}
			}
		}
	}
}
