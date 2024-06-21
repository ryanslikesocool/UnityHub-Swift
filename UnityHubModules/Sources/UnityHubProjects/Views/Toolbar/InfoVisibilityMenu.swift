import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct InfoVisibilityMenu: View {
	@AppSetting(project: \.infoVisibility) private var infoVisibility

	var body: some View {
		Menu(
			content: {
				Toggle("Icon", isOn: $infoVisibility[.icon])
				Toggle("Last Opened", isOn: $infoVisibility[.lastOpened])
				Toggle("Location", isOn: $infoVisibility[.location])
			},
			label: Label.visibility
		)
	}
}
