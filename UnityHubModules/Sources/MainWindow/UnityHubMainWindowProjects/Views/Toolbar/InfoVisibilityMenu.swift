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
			Toggle("Icon", isOn: $infoVisibility[.icon])
			Toggle("Last Opened", isOn: $infoVisibility[.lastOpened])
			Toggle("Location", isOn: $infoVisibility[.location])
		}

		Section("Editor") {
			Toggle("Version", isOn: $infoVisibility[.editorVersion])
			Toggle("Badge", isOn: $infoVisibility[.editorVersionBadge])
				.disabled(!infoVisibility[.editorVersion])
		}
	}
}
