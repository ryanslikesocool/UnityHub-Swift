import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorageCommon
import UnityHubStorageInstallations
import UnityHubStorageProjects
import UnityHubStorageSettings

struct ProjectList: View {
	@AppSetting(project: \.sortCriteria) private var sortCriteria
	@AppSetting(project: \.sortOrder) private var sortOrder
	@CacheFile(ProjectCache.self) private var projects

	@State private var searchQuery: String = ""
	@State private var searchTokens: [SearchToken] = []

	var body: some View {
		CacheListView(
			items: $projects.projects,
			itemFilter: filterFunction,
			item: Item.init,
			noItems: EmptyList.init
		)
		.dropDestination(for: URL.self, action: onDropURLs)
		.searchable(text: $searchQuery, editableTokens: $searchTokens, token: SearchTokenEditor.init)
		.searchSuggestions { SearchTokenSuggestions(searchTokens) }
	}
}

// MARK: - Functions

private extension ProjectList {
	func onDropURLs(urls: [URL], point: CGPoint) -> Bool {
		var result: Bool = false
		for url in urls {
			do {
				try projects.add(at: url)
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

		let sortComparators: [any SortComparator<ProjectMetadata>] = [
			ProjectMetadata.pinnedComparator(),
			sortCriteria.comparator(order: sortOrder),
		]
		return result.sorted(using: sortComparators)

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
