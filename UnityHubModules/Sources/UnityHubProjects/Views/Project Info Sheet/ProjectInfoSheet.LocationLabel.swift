import SwiftUI
import UnityHubCommonViews

extension ProjectInfoSheet {
	struct LocationLabel: View {
		private let url: URL

		init(_ url: URL) {
			self.url = url
		}

		var body: some View {
			URLLabel(url)
				.foregroundStyle(.secondary)
				.contextMenu {
					Button.showInFinder(destination: url)
						.labelStyle(.titleAndIcon)
				}
		}
	}
}
