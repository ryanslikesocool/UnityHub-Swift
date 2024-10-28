import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct GeneralTab: SettingsCategoryView {
	static let category: SettingsCategory = .general

	func makeLabel() -> some View {
		SwiftUI.Label("General", systemImage: Symbol.gearShape)
	}

	func makeContent() -> some View {
		Section {
			AppearancePicker()
		}

		Section {
			DialogSuppressionResetButton()
		}
	}
}
