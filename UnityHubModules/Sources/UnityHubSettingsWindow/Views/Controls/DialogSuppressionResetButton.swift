import SwiftUI
import UnityHubCommon
import UnityHubStorageSettings

struct DialogSuppressionResetButton: View {
	@AppSetting(general: \.dialogSuppression) private var selection

	public init() { }

	public var body: some View {
		LabeledContent {
			Button(
				String(localized: .dialogSuppressionReset.action),
				systemImage: .arrow_clockwise
			) {
				selection = .none
			}
		} label: {
			Text(.dialogSuppressionReset.label)
			Text(.dialogSuppressionReset.description)
		}
	}
}
