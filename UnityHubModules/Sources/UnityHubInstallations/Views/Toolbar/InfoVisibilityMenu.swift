import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct InfoVisibilityMenu: View {
	@AppSetting(installation: \.infoVisibility) private var infoVisibility

	var body: some View {
		Menu(
			content: {
				Toggle("Location", isOn: $infoVisibility[.location])
			},
			label: Label.visibility
		)
	}
}
