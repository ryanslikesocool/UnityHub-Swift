import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

extension GeneralTab {
	struct AppearancePicker: View {
		@AppSetting(general: \.appearance) private var selection

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
}
