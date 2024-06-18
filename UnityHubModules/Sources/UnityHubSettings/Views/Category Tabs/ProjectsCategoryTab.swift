import SwiftUI
import UnityHubStorage

struct ProjectsCategoryTab: AppSettingsCategoryView {
	typealias Label = SwiftUI.Label<Text, Image>

	@Binding var model: AppSettings.Projects

	var content: some View {
		Toggle(isOn: $model.quitAfterOpening) {
			Text("Quit After Opening")
			Text("Automatically quit the Unity Hub app after opening a project.")
		}
	}
}
