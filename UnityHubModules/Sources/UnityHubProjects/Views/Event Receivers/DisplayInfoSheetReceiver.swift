import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct DisplayInfoSheetReceiver: View {
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var projectURL: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.displayInfoSheet) { projectURL = $0 }
			.sheet(item: $projectURL) { url in
				if let binding = Binding($projectCache[url]) {
					ProjectInfoSheet(binding)
				}
			}
	}
}
