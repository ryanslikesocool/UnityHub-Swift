import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct InfoVisibilityMenu: View {
	@Binding var selection: InstallationInfoVisibility.Mask

	var body: some View {
		Menu(
			content: {
				Toggle("Location", isOn: $selection[.location])
			},
			label: Label.visibility
		)
	}
}
