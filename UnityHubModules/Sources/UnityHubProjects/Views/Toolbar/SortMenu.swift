import SwiftUI
import UnityHubSettingsStorage

struct SortMenu: View {
	@Binding var criteria: ProjectSortCriteria
	@Binding var order: SortOrder

	var body: some View {
		Menu("Sort", systemImage: "arrow.up.arrow.down") {
			Picker("Criteria", selection: $criteria) {
				Text("Name").tag(ProjectSortCriteria.name)
				Text("Last Opened").tag(ProjectSortCriteria.lastOpened)
				Text("Editor Version").tag(ProjectSortCriteria.editorVersion)
			}
			.pickerStyle(.inline)
			.labelsHidden()

			Picker("Order", selection: $order) {
				Text("Ascending").tag(SortOrder.forward)
				Text("Descending").tag(SortOrder.reverse)
			}
			.pickerStyle(.inline)
		}
	}
}

private extension SortMenu {
	func makeBinding(for sortOrder: SortOrder) -> Binding<Bool> {
		Binding<Bool>(
			get: { sortOrder == self.order },
			set: { newValue in
				if newValue {
					self.order = sortOrder
				}
			}
		)
	}
}
