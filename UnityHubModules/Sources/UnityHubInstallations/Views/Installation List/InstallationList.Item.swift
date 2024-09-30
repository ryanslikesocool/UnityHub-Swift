import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension InstallationList {
	struct Item: View {
		@AppSetting(installation: \.infoVisibility) private var infoVisiblity

		private let installation: InstallationMetadata

		public init(_ installation: Binding<InstallationMetadata>) {
			self.installation = installation.wrappedValue
		}

		public var body: some View {
			ListItem(content: labelContent, menu: contextMenu, issue: issueMenu)
				.contextMenu(menuItems: contextMenu)
		}
	}
}

// MARK: - Supporting Views

private extension InstallationList.Item {
	@ViewBuilder func labelContent() -> some View {
		VStack(alignment: .leading, spacing: 1) {
			VersionLabel(try? installation.version)

			if
				infoVisiblity.contains(.location),
				installation.applicationExists
			{
				URLLabel(installation.url)
					.urlLabelStyle(.listItem)
			}
		}

		Spacer()
	}

	func contextMenu() -> some View {
		ContextMenu(installation)
	}

	func issueMenu() -> some View {
		IssueMenu(
			installationURL: installation.url,
			missingInstallation: !installation.applicationExists
		)
	}
}
