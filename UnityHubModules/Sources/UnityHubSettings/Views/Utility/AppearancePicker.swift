import SwiftUI
import UnityHubSettingsStorage

struct AppearancePicker: View {
	@Binding private var selection: AppAppearance

	init(_ selection: Binding<AppAppearance>) {
		_selection = selection
	}

	var body: some View {
		Picker("Appearance", selection: $selection) {
			Section {
				Text("Light").tag(AppAppearance.light)
				Text("Dark").tag(AppAppearance.dark)
			}

			Text("Automatic").tag(AppAppearance.automatic)
		}
	}
}
