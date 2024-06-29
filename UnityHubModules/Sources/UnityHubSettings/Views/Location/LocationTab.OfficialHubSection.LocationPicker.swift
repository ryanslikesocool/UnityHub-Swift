import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension LocationTab.OfficialHubSection {
	struct LocationPicker: View {
		@Binding var selection: URL?

		var body: some View {
			URLPicker(
				selection: $selection,
				defaultValue: Constant.Settings.Locations.defaultOfficialHubLocation,
				allowedContentTypes: [.application],
				validator: Utility.Settings.Location.validateOfficialHub,
				label: EmptyView.init
			)
			.urlPickerStyle(.noLabel)
		}
	}
}
