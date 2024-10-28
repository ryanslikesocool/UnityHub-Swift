import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension LocationTab {
	struct OfficialHubSection: View {
		@AppSetting(location: \.officialHubLocation) private var selection

		private var isValid: Bool {
			do {
				try Utility.Settings.Location.validateOfficialHub(selection)
				return true
			} catch {
				return false
			}
		}

		var body: some View {
			Section(content: content, header: header)
		}
	}
}

// MARK: - Supporting Views

private extension LocationTab.OfficialHubSection {
	@ViewBuilder func content() -> some View {
		LocationPicker(selection: $selection)

		HideApplicationToggle(applicationURL: selection ?? LocationSettings.defaultOfficialHubLocation)
			.disabled(!isValid)
	}

	@ViewBuilder func header() -> some View {
		Text("Official Hub")
		VStack(alignment: .leading, spacing: 0) {
			Text("The official Unity Hub is required for downloading new installations.")
			RealLink(destination: Constant.Link.officialUnityHub) {
				SwiftUI.Label(
					title: { Text("Get it from the official site") },
					icon: {
						Image(systemName: Symbol.arrow_up_forward)
							.fontWeight(.medium)
							.scaleEffect(0.9, anchor: .bottomLeading)
					}
				)
				.labelStyle(.textTrailingIcon)
			}
		}
	}
}
