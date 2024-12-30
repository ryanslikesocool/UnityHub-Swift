import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageSettings

extension GeneralTab {
	struct DialogSuppressionResetButton: View {
		@AppSetting(general: \.dialogSuppression) private var selection

		var body: some View {
			LabeledContent {
				Button("Reset", systemImage: Symbol.arrow_clockwise) {
					selection = .none
				}
			} label: {
				Text("Reset Dialog Suppression")
				Text(#"Reset all dialogs that were marked "Don't ask again"."#)
			}
		}
	}
}
