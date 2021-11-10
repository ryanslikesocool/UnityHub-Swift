import SwiftUI

struct SettingsView_General: SettingsPage {
	static let tag = "General"
	
	@Binding var settings: AppSettings_General
	
	@ViewBuilder var content: some View {
		SettingsView.widePicker("Appearance", selection: $settings.appearance) {
			Text("Automatic").tag(AppSettings_General.Appearance.automatic)
			Divider()
			Text("Light").tag(AppSettings_General.Appearance.light)
			Text("Dark").tag(AppSettings_General.Appearance.dark)
		}
    }
	
	@ViewBuilder static var label: some View {
		Label("General", systemImage: "gearshape")
	}
}
