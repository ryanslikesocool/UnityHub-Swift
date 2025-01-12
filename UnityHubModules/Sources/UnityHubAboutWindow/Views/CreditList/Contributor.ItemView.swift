import SwiftUI
import UnityHubCommonViews

extension Contributor {
	struct ItemView: CreditItemView {
		private let item: Item

		public init(_ item: Contributor) {
			self.item = item
		}

		public var body: some View {
			LabeledContent {
				personalLink
				githubLink
			} label: {
				Text(verbatim: item.name)
			}
		}
	}
}

// MARK: - Supporting Views

private extension Contributor.ItemView {
	@ViewBuilder
	var personalLink: some View {
		if let url = item.personalURL {
			RealLink(destination: url) {
				Label(
					String(localized: .credits.link.website),
					systemImage: .link
				)
			}
		}
	}

	@ViewBuilder
	var githubLink: some View {
		if let url = item.githubURL {
			// TODO: add github icon
			RealLink(destination: url) {
				Label {
					Text(.credits.link.github)
				} icon: {
					EmptyView()
				}
			}
		}
	}
}
