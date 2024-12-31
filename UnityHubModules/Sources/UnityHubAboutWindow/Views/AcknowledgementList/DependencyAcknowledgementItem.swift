import SwiftUI
import UnityHubCommonViews

struct DependencyAcknowledgementItem: AcknowledgementItemView {
	private let acknowledgement: Dependency

	public init(_ acknowledgement: Dependency) {
		self.acknowledgement = acknowledgement
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

private extension DependencyAcknowledgementItem {
	func makeTitle() -> some View {
		Text(acknowledgement.title)
	}

	func makePrimaryLink() -> some View {
		RealLink(destination: acknowledgement.url) {
			Label(
				String(localized: .acknowledgements.link.website),
				systemImage: .link
			)
		}
	}

	@ViewBuilder
	func makeLicenseLink() -> some View {
		if let url = acknowledgement.licenseURL {
			RealLink(destination: url) {
				Label(
					String(localized: .acknowledgements.link.license),
					systemImage: .building_columns // TODO: replace with scales symbol if/when one becomes available
				)
			}
		}
	}
}
