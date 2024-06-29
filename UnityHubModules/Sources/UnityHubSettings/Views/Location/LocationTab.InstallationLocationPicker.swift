import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension LocationTab {
	struct InstallationLocationPicker: View {
		@State private var error: LocationError? = nil

		@Binding var selection: URL?

		var body: some View {
			URLPicker(
				selection: $selection,
				defaultValue: Constant.Settings.Locations.defaultInstallationLocation,
				allowedContentTypes: [.folder],
				validator: Utility.Settings.Location.validateInstallationLocation
			) {
				Text("Installations")
				Text("Existing installations will not be affected.")
			}
		}
	}
}
