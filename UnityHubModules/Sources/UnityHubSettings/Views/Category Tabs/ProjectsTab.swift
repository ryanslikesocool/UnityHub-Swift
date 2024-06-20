import SwiftUI
import UnityHubStorage

struct ProjectsTab: AppSettingsCategoryView {
	@Binding var model: AppSettings.Projects

	func content() -> some View {
		Section {
			Picker(selection: $model.projectBackgroundMode) {
				Text("None").tag(ProjectBackgroundMode.none)
				Section {
					Text("Hide").tag(ProjectBackgroundMode.hide)
					Text("Quit").tag(ProjectBackgroundMode.quit)
				}
				.selectionDisabled()
			} label: {
				Text("Background Mode")
				Text("After opening a project, this action will be performed.")
			}
		}
	}

	func label() -> some View {
		SwiftUI.Label.projects()
	}
}
