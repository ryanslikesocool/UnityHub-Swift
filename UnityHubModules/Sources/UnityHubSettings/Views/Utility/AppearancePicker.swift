import SwiftUI
import UnityHubStorage

struct AppearancePicker: View {
	@Binding private var selection: AppAppearance

	init(_ selection: Binding<AppAppearance>) {
		_selection = selection
	}

	var body: some View {
		Picker("Appearance", selection: $selection) {
			Text("Automatic").tag(AppAppearance.automatic)

			Section {
				Text("Light").tag(AppAppearance.light)
				Text("Dark").tag(AppAppearance.dark)
			}
		}
	}
}
