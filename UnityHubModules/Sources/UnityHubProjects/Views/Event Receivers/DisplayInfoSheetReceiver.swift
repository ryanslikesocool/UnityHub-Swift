import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct DisplayProjectInfoReceiver: View {
	@Cache(ProjectCache.self) private var projects

	@State private var projectURL: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.displayProjectInfo, perform: receiveEvent)
			.sheet(item: $projectURL) { url in
				if let binding = Binding($projects[url]) {
					ProjectInfoSheet(binding)
				}
			}
	}
}

// MARK: - Functions

private extension DisplayProjectInfoReceiver {
	func receiveEvent(value: URL) {
		projectURL = value
	}
}
