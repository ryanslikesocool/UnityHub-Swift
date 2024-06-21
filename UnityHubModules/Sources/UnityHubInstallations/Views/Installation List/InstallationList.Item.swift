import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension InstallationList {
	struct Item: View {
		@AppSetting(installation: \.infoVisibility) private var infoVisiblity

		@Binding private var installation: InstallationMetadata

		init(_ installation: Binding<InstallationMetadata>) {
			_installation = installation
		}

		var body: some View {
			ListItem(content: labelContent, menu: contextMenu)
				.contextMenu(menuItems: contextMenu)
				.onAppear { installation.validateLazyData() }
		}
	}
}

// MARK: - Supporting Views

private extension InstallationList.Item {
	@ViewBuilder func labelContent() -> some View {
		let exists: Bool = installation.url.exists

		VStack(alignment: .leading, spacing: 1) {
			VersionLabel(installation.version)

			if
				infoVisiblity.contains(.location),
				exists
			{
				URLLabel(installation.url)
					.urlLabelStyle(.listItem)
			}
		}

		Spacer()

		if !exists {
			MissingObjectButton {
				Event.missingInstallation(installation.url)
			}
		}
	}

	func contextMenu() -> some View {
		ContextMenu(installation)
	}
}
