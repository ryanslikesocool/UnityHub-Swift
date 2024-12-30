import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageProjects
import UnityHubStorageSettings

struct SortMenu: View {
	@AppSetting(project: \.sortCriteria) private var sortCriteria
	@AppSetting(project: \.sortOrder) private var sortOrder

	var body: some View {
		Menu(
			content: makeContent,
			label: Label.sort,
			primaryAction: primaryAction
		)
		.pickerStyle(.inline)
	}
}

// MARK: - Supporting Views

private extension SortMenu {
	@ViewBuilder
	func makeContent() -> some View {
		Picker("Criteria", selection: $sortCriteria) {
			Text("Name").tag(ProjectSortCriteria.name)
			Text("Last Opened").tag(ProjectSortCriteria.lastOpened)
			Text("Editor Version").tag(ProjectSortCriteria.editorVersion)
		}
		.labelsHidden()

		SortOrderPicker("Order", selection: $sortOrder)
	}
}

// MARK: - Functions

private extension SortMenu {
	func primaryAction() {
		sortOrder = sortOrder.inverse
	}
}
