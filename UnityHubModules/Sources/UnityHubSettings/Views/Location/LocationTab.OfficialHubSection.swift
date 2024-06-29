import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension LocationTab {
	struct OfficialHubSection: View {
		@AppSetting(location: \.officialHubLocation) private var selection

		var body: some View {
			Section(content: content, header: header)
		}
	}
}

// MARK: - Supporting Views

private extension LocationTab.OfficialHubSection {
	@ViewBuilder func content() -> some View {
		LocationPicker(selection: $selection)

		// TODO: make value dynamic
		HideApplicationToggle(isOn: .constant(true))
			.disabled(false) // TODO: disable if bad location
	}

	@ViewBuilder func header() -> some View {
		Text("Official Hub")
		VStack(alignment: .leading, spacing: 0) {
			Text("The official Unity Hub is required for downloading new installations.")
			RealLink(destination: Constant.Link.officialHub) {
				SwiftUI.Label(
					title: { Text("Get it from the official site") },
					icon: {
						Image(systemName: Constant.Symbol.arrow_up_forward)
							.fontWeight(.medium)
							.scaleEffect(0.9, anchor: .bottomLeading)
					}
				)
				.labelStyle(.textTrailingIcon)
			}
		}
	}
}
