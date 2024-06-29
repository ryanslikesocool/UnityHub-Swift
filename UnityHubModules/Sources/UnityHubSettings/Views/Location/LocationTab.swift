import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct LocationTab: SettingsCategoryView {
	@Bindable var model: LocationSettings = .shared

	func makeContent() -> some View {
		Group {
			InstallationLocationPicker(selection: $model.installationLocation)
			DownloadLocationPicker(selection: $model.downloadLocation)
		}
		.urlPickerStyle(.section)

		OfficialHubSection(model: model)
	}

	func makeLabel() -> some View {
		SwiftUI.Label("Locations", systemImage: Constant.Symbol.externalDrive)
	}
}
