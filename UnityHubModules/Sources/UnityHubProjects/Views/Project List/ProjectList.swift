import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct ProjectList: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var searchQuery: String = ""
	@State private var searchTokens: [SearchToken] = []

	var body: some View {
		CacheListView(
			items: $projectCache.projects,
			itemFilter: filterFunction,
			item: Item.init,
			noItems: noProjects
		)
		.searchable(text: $searchQuery, editableTokens: $searchTokens, token: SearchTokenEditor.init)
		.searchSuggestions { SearchTokenSuggestions(searchTokens) }
	}
}

// MARK: - Supporting Views

private extension ProjectList {
	func noProjects() -> some View {
		VStack {
			Label("No Projects", systemImage: Constant.Symbol.cube)
				.labelStyle(.large)

			Text("Drop a project or")
				.foregroundStyle(.secondary)
			Button(
				action: {
					Event.locateProject(.add)
				},
				label: Label.locate
			)
			.controlSize(.large)
		}
	}
}

// MARK: - Functions

private extension ProjectList {
	func filterFunction(projects: [ProjectMetadata]) -> [ProjectMetadata] {
		var result: [ProjectMetadata] = projects

		if !searchQuery.isEmpty {
			result = result.filter { project in
				(project.name ?? project.url.lastPathComponent).localizedStandardContains(searchQuery)
			}
		}

		for token in searchTokens {
			switch token {
				case let .pinned(state): filterPinned(state: state)
				case let .editorVersion(editorVersion): filterEditorVersion(editorVersion: editorVersion)
			}
		}

		return result
			.sorted(
				by: appSettings.projects.sortCriteria,
				order: appSettings.projects.sortOrder
			)

		func filterPinned(state: Bool) {
			result = result.filter { $0.pinned == state }
		}

		func filterEditorVersion(editorVersion: UnityEditorVersion) {
			switch editorVersion {
				case .search_any:
					return
				case .search_missing:
					// TODO: implement
					return
				default:
					result = result.filter(by: \.editorVersion, equals: editorVersion)
			}
		}
	}
}
