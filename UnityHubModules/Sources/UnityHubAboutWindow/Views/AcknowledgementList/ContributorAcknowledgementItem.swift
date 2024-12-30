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
		.labelStyle(.iconOnly)
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
				Label {
					Text("Website")
				} icon: {
					Image(systemName: "link")
				}
			}
		}
	}

	@ViewBuilder
	func makeGitHubLink() -> some View {
		if let url = acknowledgement.githubURL {
			RealLink(destination: url) {
				Label {
					Text("GitHub")
				} icon: {
					EmptyView()
					// TODO: add github icon asset
//					Image("github")
				}
			}
		}
	}
}