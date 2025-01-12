import SwiftUI
import UnityHubCommonViews

struct AcknowledgementCreditItem: CreditItemView {
	private let credit: Acknowledgement

	public init(_ credit: Acknowledgement) {
		self.credit = credit
	}

	public var body: some View {
		HStack {
			makeTitle()

			Spacer()

			makeLicenseLink()
			makePrimaryLink()
		}
	}
}

// MARK: - Supporting Views

private extension AcknowledgementCreditItem {
	func makeTitle() -> some View {
		Text(credit.title)
	}

	func makePrimaryLink() -> some View {
		RealLink(destination: credit.projectURL) {
			Label(
				String(localized: .acknowledgements.link.website),
				systemImage: .link
			)
		}
	}

	@ViewBuilder
	func makeLicenseLink() -> some View {
		if let url = credit.licenseURL {
			RealLink(destination: url) {
				Label(
					String(localized: .acknowledgements.link.license),
					systemImage: .building_columns // TODO: replace with scales symbol if/when one becomes available
				)
			}
		}
	}
}
