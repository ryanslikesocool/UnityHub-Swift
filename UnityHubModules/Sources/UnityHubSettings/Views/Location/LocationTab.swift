import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocationTab: SettingsCategoryView {
	static let category: SettingsCategory = .locations

	func makeContent() -> some View {
		Group {
			InstallationLocationPicker()
			DownloadLocationPicker()
		}
		.urlPickerStyle(.section)

		OfficialHubSection()
	}

	func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: Constant.Symbol.externalDrive)
	}
}
