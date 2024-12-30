import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageSettings

struct LocationTab: SettingsCategoryView {
	static let category: SettingsCategory = .locations

	func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: .externalDrive)
	}

	func makeContent() -> some View {
		Group {
			InstallationLocationPicker()
			DownloadLocationPicker()
		}
		.urlPickerStyle(.section)

		OfficialHubSection()
	}
}
