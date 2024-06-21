import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocationSettingsTab: SettingsCategoryView {
	@Bindable var model: LocationSettings = .shared

	func makeContent() -> some View {
		Group {
			URLPicker(
				selection: $model.installationLocation,
				defaultValue: Constant.Settings.Locations.defaultInstallationLocation,
				allowedContentTypes: [.folder]
			) {
				Text("Installation Location")
				Text("Existing installations will not be affected.")
			}

			URLPicker(
				"Download Location",
				selection: $model.downloadLocation,
				defaultValue: Constant.Settings.Locations.defaultDownloadLocation,
				allowedContentTypes: [.folder]
			)
		}
		.urlPickerStyle(.section)
	}

	func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: Constant.Symbol.externalDrive)
	}
}
