import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct DisplayInfoSheetReceiver: View {
	@Cache(ProjectCache.self) private var projects

	@State private var projectURL: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.displayInfoSheet, perform: receiveEvent)
			.sheet(item: $projectURL) { url in
				if let binding = Binding($projects[url]) {
					ProjectInfoSheet(binding)
				}
			}
	}
}

// MARK: - Functions

private extension DisplayInfoSheetReceiver {
	func receiveEvent(value: URL) {
		projectURL = value
	}
}
