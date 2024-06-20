import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct DisplayInfoSheetReceiver: View {
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var projectURL: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.displayInfoSheet, perform: receiveEvent)
			.sheet(item: $projectURL) { url in
				if let binding = Binding($projectCache[url]) {
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
