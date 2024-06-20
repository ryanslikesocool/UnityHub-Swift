import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

struct InstallationsTab: AppSettingsCategoryView {
	@Binding var model: AppSettings.Installations

	func content() -> some View {
		Group {
			URLPicker(
				selection: $model.installationLocation,
				defaultValue: Model.defaultInstallationLocation,
				allowedContentTypes: [.folder]
			) {
				Text("Installation Location")
				Text("Existing installations will not be affected.")
			}

			URLPicker(
				"Download Location",
				selection: $model.downloadLocation,
				defaultValue: Model.defaultDownloadLocation,
				allowedContentTypes: [.folder]
			)
		}
		.urlPickerStyle(.section)
	}

	func label() -> some View {
		SwiftUI.Label.installations()
	}
}
