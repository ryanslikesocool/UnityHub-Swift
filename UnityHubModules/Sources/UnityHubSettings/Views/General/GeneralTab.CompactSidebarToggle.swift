import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

extension GeneralTab {
	struct CompactSidebarToggle: View {
		@AppSetting(general: \.compactSidebar) private var isOn

		var body: some View {
			Toggle("Compact Sidebar", isOn: $isOn)
		}
	}
}
