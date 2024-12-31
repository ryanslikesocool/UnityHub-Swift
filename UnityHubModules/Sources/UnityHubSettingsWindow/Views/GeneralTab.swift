import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageSettings

struct GeneralTab: SettingsCategoryView {
	public static let category: SettingsCategory = .general

	public func makeLabel() -> some View {
		SwiftUI.Label("General", systemImage: .gearShape)
	}

	public func makeContent() -> some View {
		Section {
			AppearancePicker()
		}

		Section {
			DialogSuppressionResetButton()
		}
	}
}
