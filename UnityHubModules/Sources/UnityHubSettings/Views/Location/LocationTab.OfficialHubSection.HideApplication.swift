import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension LocationTab.OfficialHubSection {
	struct HideApplicationToggle: View {
		@Binding var isOn: Bool

		var body: some View {
			Toggle("Hide In Dock", isOn: $isOn)
		}
	}
}
