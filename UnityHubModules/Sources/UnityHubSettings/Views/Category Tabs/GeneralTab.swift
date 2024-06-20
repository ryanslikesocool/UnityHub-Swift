import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct GeneralTab: AppSettingsCategoryView {
	@Binding var model: AppSettings.General

	func content() -> some View {
		AppearancePicker($model.appearance)

		Section{
			LabeledContent {
				Button("Reset", systemImage: Constant.Symbol.arrow_clockwise) {
					model.dialogSuppression = .none
				}
			} label: {
				Text("Reset Warnings")
				Text(#"Reset all warnings that were marked "Don't ask again"."#)
			}
		}
	}

	func label() -> some View {
		SwiftUI.Label("General", systemImage: Constant.Symbol.gearShape)
	}
}
