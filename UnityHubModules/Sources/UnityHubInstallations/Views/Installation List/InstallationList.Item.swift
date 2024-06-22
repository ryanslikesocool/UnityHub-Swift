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
		}
	}
}

// MARK: - Supporting Views

private extension InstallationList.Item {
	@ViewBuilder func labelContent() -> some View {
		let fileManager: FileManager = .default
		let exists: Bool = fileManager.fileExists(at: installation.url)

		VStack(alignment: .leading, spacing: 1) {
			VersionLabel(try? installation.version)

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
				Event.Installation.missing(installation.url)
			}
		}
	}

	func contextMenu() -> some View {
		ContextMenu(installation)
	}
}
