import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocationTab: SettingsCategoryView {
	static let category: SettingsCategory = .locations

	func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: Symbol.externalDrive)
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
