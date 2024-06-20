import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension InstallationList {
	struct Item: View {
		@Binding private var installation: InstallationMetadata

		init(_ installation: Binding<InstallationMetadata>) {
			_installation = installation
		}

		var body: some View {
			ListItem(content: labelContent, menu: contextMenu)
				.contextMenu(menuItems: contextMenu)
		}
	}
}

// MARK: - Supporting Views

private extension InstallationList.Item {
	@ViewBuilder func labelContent() -> some View {
		VStack(alignment: .leading, spacing: 1) {
			VersionLabel(installation.version)

			URLLabel(installation.url)
				.urlLabelStyle(.listItem)
		}

		Spacer()
	}

	func contextMenu() -> some View {
		ContextMenu(installation)
	}
}
