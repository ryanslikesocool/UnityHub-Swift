import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct GeneralTab: SettingsCategoryView {
	static let category: SettingsCategory = .general

	func makeContent() -> some View {
		Section {
			AppearancePicker()
		}

		Section {
			DialogSuppressionResetButton()
		}
	}

	func makeLabel() -> some View {
		SwiftUI.Label("General", systemImage: Constant.Symbol.gearShape)
	}
}
