import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageProjects
import UnityHubStorageSettings

struct InfoVisibilityMenu: View {
	@AppSetting(project: \.infoVisibility) private var infoVisibility

	var body: some View {
		Menu(
			content: makeContent,
			label: Label.visibility
		)
	}
}

// MARK: - Supporting Views

private extension InfoVisibilityMenu {
	@ViewBuilder
	func makeContent() -> some View {
		Section {
			Toggle(
				.visibilityMenu.item.icon,
				isOn: $infoVisibility[.icon]
			)

			Toggle(
				.visibilityMenu.item.lastOpened,
				isOn: $infoVisibility[.lastOpened]
			)

			Toggle(
				.visibilityMenu.item.location,
				isOn: $infoVisibility[.location]
			)
		}

		Section {
			Toggle(
				.visibilityMenu.item.version,
				isOn: $infoVisibility[.editorVersion]
			)

			Toggle(
				.visibilityMenu.item.badge,
				isOn: $infoVisibility[.editorVersionBadge]
			)
			.disabled(!infoVisibility[.editorVersion])
		} header: {
			Text(.visibilityMenu.group.editor)
		}
	}
}
