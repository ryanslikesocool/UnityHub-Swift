import OSLog
import SwiftUI
import UnityHubStorage

public struct ProjectsView: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var projectCache: ProjectCache = .shared

	public init() { }

	public var body: some View {
		ProjectList()
			.toolbar {
				ToolbarItemGroup(placement: .confirmationAction) {
					AddProjectButton()
					ProjectInfoVisibilityMenu(selection: $appSettings.projects.infoVisibility)
					SortMenu(criteria: $appSettings.projects.sortCriteria, order: $appSettings.projects.sortOrder)
				}
			}
			.dropDestination(for: URL.self, action: onDropURLs)

			/// cannot combine event receivers into a single `.background`
			/// for some reason, `EmptyView` works if done this way
			.background(content: ImportProjectReceiver.init)
			.background(content: RemoveProjectReceiver.init)
			.background(content: InvalidProjectReceiver.init)
	}
}

// MARK: - Functions

private extension ProjectsView {
	func onDropURLs(urls: [URL], point: CGPoint) -> Bool {
		var result: Bool = false
		for url in urls {
			do {
				try projectCache.addProject(at: url)
				result = true
			} catch {
				Logger.module.warning("""
				Failed to import project at \(url.path(percentEncoded: false)) during a mass-import:
				\(error.localizedDescription)
				""")
				continue
			}
		}

		return result
	}
}
