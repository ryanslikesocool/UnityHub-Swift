import SwiftUI
import UnityHubStorage

struct AppearancePicker: View {
	@Binding var selection: Appearance

	var body: some View {
		Picker("Appearance", selection: $selection) {
			Text("Automatic").tag(Appearance.automatic)

			Section {
				Text("Light").tag(Appearance.light)
				Text("Dark").tag(Appearance.dark)
			}
		}
		.onChange(of: selection, selection.apply)
	}
}
