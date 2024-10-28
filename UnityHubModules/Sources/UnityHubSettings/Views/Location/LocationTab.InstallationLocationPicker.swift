import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension LocationTab {
	struct InstallationLocationPicker: View {
		@AppSetting(location: \.installationLocation) private var selection

		@State private var error: LocationError? = nil

		var body: some View {
			URLPicker(
				selection: $selection,
				defaultValue: LocationSettings.defaultInstallationLocation,
				allowedContentTypes: [.folder],
				validator: Utility.Settings.Location.validateInstallationLocation
			) {
				Text("Installations")
				Text("Existing installations will not be affected.")
			}
			.fileDialogDefaultDirectory(LocationSettings.defaultInstallationLocation)
		}
	}
}
