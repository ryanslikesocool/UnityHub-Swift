import SwiftUI
import UnityHubCommonViews

struct ContributorCreditItem: CreditItemView {
	private let credit: Contributor

	public init(_ credit: Contributor) {
		self.credit = credit
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

private extension ContributorCreditItem {
	func makeTitle() -> some View {
		Text(credit.name)
	}

	@ViewBuilder
	func makePersonalLink() -> some View {
		if let url = credit.personalURL {
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
		if let url = credit.githubURL {
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
