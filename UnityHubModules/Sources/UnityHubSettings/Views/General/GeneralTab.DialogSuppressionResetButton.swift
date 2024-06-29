import SwiftUI
import UnityHubCommon
import UnityHubStorage

extension GeneralTab {
	struct DialogSuppressionResetButton: View {
		@Binding var selection: DialogSuppression

		var body: some View {
			LabeledContent {
				Button("Reset", systemImage: Constant.Symbol.arrow_clockwise) {
					selection = .none
				}
			} label: {
				Text("Reset Dialog Suppression")
				Text(#"Reset all dialogs that were marked "Don't ask again"."#)
			}
		}
	}
}
