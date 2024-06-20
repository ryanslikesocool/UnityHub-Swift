import SwiftUI
import UnityHubStorage

struct ProjectsTab: AppSettingsCategoryView {
	typealias Label = SwiftUI.Label<Text, Image>

	@Binding var model: AppSettings.Projects

	var content: some View {
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
}
