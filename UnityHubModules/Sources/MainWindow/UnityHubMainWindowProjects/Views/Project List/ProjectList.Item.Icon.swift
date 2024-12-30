import SwiftUI
import UnityHubCommonViews
import UnityHubCommon
import UnityHubStorageProjects
import UserIcon

extension ProjectList.Item {
	struct Icon: View {
		@Binding private var icon: UserIcon

		init(_ icon: Binding<UserIcon>) {
			_icon = icon
		}

		var body: some View {
			Group {
				if icon != .blank {
					UserIconView(icon)
				} else {
					Color.clear
				}
			}
			.aspectRatio(1, contentMode: .fit)
			.frame(width: Constant.ListItem.height)
		}
	}
}
