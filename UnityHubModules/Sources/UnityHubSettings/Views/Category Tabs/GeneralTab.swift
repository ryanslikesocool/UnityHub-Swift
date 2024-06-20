import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct GeneralTab: AppSettingsCategoryView {
	typealias Label = SwiftUI.Label<Text, Image>

	@Binding var model: AppSettings.General

	var content: some View {
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
}
