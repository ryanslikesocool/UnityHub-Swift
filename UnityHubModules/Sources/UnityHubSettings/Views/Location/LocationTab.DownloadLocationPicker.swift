import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension LocationTab {
	struct DownloadLocationPicker: View {
		@State private var error: LocationError? = nil
		
		@Binding var selection: URL?

		var body: some View {
			URLPicker(
				"Downloads",
				selection: $selection,
				defaultValue: Constant.Settings.Locations.defaultDownloadLocation,
				allowedContentTypes: [.folder],
				validator: Utility.Settings.Location.validateDownloadLocation
			)
		}
	}
}
