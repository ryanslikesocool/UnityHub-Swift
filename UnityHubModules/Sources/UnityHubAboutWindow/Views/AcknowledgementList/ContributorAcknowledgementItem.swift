import SwiftUI
import UnityHubCommonViews

struct ContributorAcknowledgementItem: AcknowledgementItemView {
	private let acknowledgement: Contributor

	public init(_ acknowledgement: Contributor) {
		self.acknowledgement = acknowledgement
	}

	public var body: some View {
		HStack {
			makeTitle()

			Spacer()

			makeGitHubLink()
			makePersonalLink()
		}
	}
}

// MARK: - Supporting Views

private extension ContributorAcknowledgementItem {
	func makeTitle() -> some View {
		Text(acknowledgement.name)
	}

	@ViewBuilder
	func makePersonalLink() -> some View {
		if let url = acknowledgement.personalURL {
			RealLink(destination: url) {
				Label(
					String(localized: .acknowledgements.link.website),
					systemImage: .link
				)
			}
		}
	}

	@ViewBuilder
	func makeGitHubLink() -> some View {
		if let url = acknowledgement.githubURL {
			RealLink(destination: url) {
				Label {
					Text(.acknowledgements.link.github)
				} icon: {
					EmptyView()
					// TODO: add github icon asset
//					Image("github")
				}
			}
		}
	}
}
