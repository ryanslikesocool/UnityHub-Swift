import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageCommon
import UnityHubStorageProjects

struct DisplayProjectInfoReceiver: View {
	@CacheFile(ProjectCache.self) private var projects

	@State private var projectURL: URL? = nil

	var body: some View {
		EmptyView()
			.onReceive(Event.Project.displayInfo, perform: receiveEvent)
			.sheet(item: $projectURL) { url in
				if let binding = Binding($projects[url]) {
					ProjectInfoSheet(binding)
				}
			}
	}

	// TODO: replace `projectURL: URL?` with `Identifier<URL>?`
}

// MARK: - Functions

private extension DisplayProjectInfoReceiver {
	func receiveEvent(value: URL) {
		projectURL = value
	}
}

// MARK: - URL+

extension URL: @retroactive Identifiable {
	public var id: Self { self }
}
