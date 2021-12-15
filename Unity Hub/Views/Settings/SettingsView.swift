import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var settings: AppSettings

    var body: some View {
        TabView {
			general
        }
    }

	@ViewBuilder private var general: some View {
		Panel(title: "General", symbol: "gearshape.fill", data: $settings.general) { data in
			WidePicker("Appearance", selection: data.appearance) {
				ForEach(AppSettings.General.Appearance.allCases) { value in
					Text(value.rawValue).tag(value)

					if value == .automatic {
						Divider()
					}
				}
			}
		}
	}
}
