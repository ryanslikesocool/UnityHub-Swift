import OSLog
import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

public struct ProjectsView: View {
	@AppSetting(project: \.infoVisibility) private var infoVisibility
	@AppSetting(project: \.sortCriteria) private var sortCriteria
	@AppSetting(project: \.sortOrder) private var sortOrder
	@Cache(ProjectCache.self) private var projects

	public init() { }

	public var body: some View {
		ProjectList()
			.toolbar {
				ToolbarItemGroup(placement: .confirmationAction) {
					AddProjectList()
					SortMenu(criteria: $sortCriteria, order: $sortOrder)
					InfoVisibilityMenu(selection: $infoVisibility)
				}
			}
			.dropDestination(for: URL.self, action: onDropURLs)

			/// cannot combine event receivers into a single `.background`
			/// for some reason, `EmptyView` works if done this way
			.background(content: LocateProjectReceiver.init)
			.background(content: RemoveProjectReceiver.init)
			.background(content: InvalidProjectReceiver.init)
			.background(content: DisplayInfoSheetReceiver.init)
			.background(content: MissingProjectReceiver.init)
	}
}

// MARK: - Functions

private extension ProjectsView {
	func onDropURLs(urls: [URL], point: CGPoint) -> Bool {
		var result: Bool = false
		for url in urls {
			do {
				try projects.addProject(at: url)
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
