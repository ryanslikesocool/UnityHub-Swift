import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension ProjectList {
	struct EmptyList: View {
		var body: some View {
			EmptyListView {
				Label("No Projects", systemImage: Constant.Symbol.cube)
			} prompt: {
				Button.createProject()
				Text("or")
				Button.locateProject()
			}
		}
	}
}
