import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct GeneralTab: SettingsCategoryView {
	@Bindable var model: GeneralSettings = .shared

	func makeContent() -> some View {
		AppearancePicker(selection: $model.appearance)

		Section {
			DialogSuppressionResetButton(selection: $model.dialogSuppression)
		}
	}

	func makeLabel() -> some View {
		SwiftUI.Label("General", systemImage: Constant.Symbol.gearShape)
	}
}
