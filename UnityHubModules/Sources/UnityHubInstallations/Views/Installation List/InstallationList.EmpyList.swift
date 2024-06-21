import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension InstallationList {
	struct EmptyList: View {
		var body: some View {
			EmptyListView {
				Label("No Installations", systemImage: Constant.Symbol.tray)
			} prompt: {
				Button.downloadInstallation()
				Text("or")
				Button.locateInstallation()
			}
		}
	}
}
