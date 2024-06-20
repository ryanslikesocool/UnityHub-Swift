import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct InfoVisibilityMenu: View {
	@Binding var selection: ProjectInfoVisibility.Mask

	var body: some View {
		Menu(
			content: {
				Toggle("Icon", isOn: $selection[.icon])
				Toggle("Last Opened", isOn: $selection[.lastOpened])
				Toggle("Location", isOn: $selection[.location])
			},
			label: Label.visibility
		)
	}
}
