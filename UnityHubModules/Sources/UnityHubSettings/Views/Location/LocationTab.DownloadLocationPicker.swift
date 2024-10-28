import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension LocationTab {
	struct DownloadLocationPicker: View {
		@AppSetting(location: \.downloadLocation) private var selection

		@State private var error: LocationError? = nil

		var body: some View {
			URLPicker(
				"Downloads",
				selection: $selection,
				defaultValue: LocationSettings.defaultDownloadLocation,
				allowedContentTypes: [.folder],
				validator: Utility.Settings.Location.validateDownloadLocation
			)
			.fileDialogDefaultDirectory(LocationSettings.defaultDownloadLocation)
		}
	}
}
