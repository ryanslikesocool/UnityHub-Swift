import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct SortMenu: View {
	@Binding var criteria: ProjectSortCriteria
	@Binding var order: SortOrder

	var body: some View {
		Menu(
			content: {
				Picker("Criteria", selection: $criteria) {
					Text("Name").tag(ProjectSortCriteria.name)
					Text("Last Opened").tag(ProjectSortCriteria.lastOpened)
					Text("Editor Version").tag(ProjectSortCriteria.editorVersion)
				}
				.labelsHidden()

				SortOrderPicker("Order", selection: $order)
			},
			label: Label.sort
		)
		.pickerStyle(.inline)
	}
}
