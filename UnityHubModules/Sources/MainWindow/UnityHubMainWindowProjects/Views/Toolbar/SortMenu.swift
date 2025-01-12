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
		ProjectSortCriteriaPicker(selection: $sortCriteria)
			.labelsHidden()

		SortOrderPicker(selection: $sortOrder)
	}
}

// MARK: - Functions

private extension SortMenu {
	func primaryAction() {
		sortOrder = sortOrder.inverse
	}
}
