import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageSettings

extension LocationTab.OfficialHubSection {
	struct LocationPicker: View {
		@Binding var selection: URL?

		var body: some View {
			URLPicker(
				selection: $selection,
				defaultValue: LocationSettings.defaultOfficialHubLocation,
				allowedContentTypes: [.application],
				validator: Utility.Settings.Location.validateOfficialHub,
				label: EmptyView.init
			)
			.urlPickerStyle(.noLabel)
			.fileDialogDefaultDirectory(LocationSettings.defaultOfficialHubLocation)
		}
	}
}
