import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

struct InstallationsTab: AppSettingsCategoryView {
	typealias Label = SwiftUI.Label<Text, Image>

	@Binding var model: AppSettings.Installations

	var content: some View {
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
}
