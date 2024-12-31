import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageSettings

struct LocationTab: SettingsCategoryView {
	public static let category: SettingsCategory = .locations

	public func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: .externalDrive)
	}

	public func makeContent() -> some View {
		Group {
			InstallationLocationPicker()
			DownloadLocationPicker()
		}
		.urlPickerStyle(.section)

		OfficialHubSection()
	}
}
