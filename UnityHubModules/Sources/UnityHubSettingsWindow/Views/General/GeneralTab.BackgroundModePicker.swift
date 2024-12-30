import SwiftUI
import UnityHubStorageSettings

extension GeneralTab {
	struct BackgroundModePicker: View {
		@Binding var selection: BackgroundMode

		var body: some View {
			Picker(selection: $selection) {
				Text("None").tag(BackgroundMode.none)

				Section {
					Text("Hide").tag(BackgroundMode.hide)
					Text("Quit").tag(BackgroundMode.quit)
				}
				.selectionDisabled()
			} label: {
				Text("Background Mode")
				Text("After opening a project, this application will enter the background in this mode.")
			}
		}
	}
}
