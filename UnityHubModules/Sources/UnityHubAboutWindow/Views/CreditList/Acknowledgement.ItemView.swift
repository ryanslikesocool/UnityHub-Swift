import SwiftUI
import UnityHubCommonViews

extension Acknowledgement {
	struct ItemView: CreditItemView {
		private let credit: Acknowledgement

		public init(_ credit: Acknowledgement) {
			self.credit = credit
		}

		public var body: some View {
			LabeledContent {
				makeLicenseLink()
				makePrimaryLink()
			} label: {
				makeTitle()
			}
		}
	}
}

// MARK: - Supporting Views

private extension Acknowledgement.ItemView {
	func makeTitle() -> some View {
		Text(credit.name)
	}

	func makePrimaryLink() -> some View {
		RealLink(destination: credit.projectURL) {
			Label(
				String(localized: .credits.link.website),
				systemImage: .link
			)
		}
	}

	@ViewBuilder
	func makeLicenseLink() -> some View {
		if let url = credit.licenseURL {
			RealLink(destination: url) {
				Label(
					String(localized: .credits.link.license),
					systemImage: .building_columns // TODO: replace with scales symbol if/when one becomes available
				)
			}
		}
	}
}
