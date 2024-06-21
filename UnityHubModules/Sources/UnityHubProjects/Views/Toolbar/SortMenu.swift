import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct SortMenu: View {
	@AppSetting(project: \.sortCriteria) private var sortCriteria
	@AppSetting(project: \.sortOrder) private var sortOrder

	var body: some View {
		Menu(
			content: {
				Picker("Criteria", selection: $sortCriteria) {
					Text("Name").tag(ProjectSortCriteria.name)
					Text("Last Opened").tag(ProjectSortCriteria.lastOpened)
					Text("Editor Version").tag(ProjectSortCriteria.editorVersion)
				}
				.labelsHidden()

				SortOrderPicker("Order", selection: $sortOrder)
			},
			label: Label.sort,
			primaryAction: { sortOrder = sortOrder.opposite }
		)
		.pickerStyle(.inline)
	}
}
