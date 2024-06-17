import SwiftUI
import UnityHubCommon
import UnityHubProjectStorage
import UnityHubSettingsStorage

struct ProjectList: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var searchQuery: String = ""
	@State private var searchTokens: [ProjectSearchToken] = []

	private var projectSearchResults: [ProjectMetadata] {
		var result: [ProjectMetadata] = projectCache.projects

		if !searchQuery.isEmpty {
			result = result.filter { project in
				project.name.localizedStandardContains(searchQuery)
			}
		}

		for token in searchTokens {
			switch token {
				case let .isPinned(pinState):
					result = result.filter { $0.pinned == pinState }
				case let .editorVersion(editorVersion):
					switch editorVersion {
						case .search_any:
							continue
						case .search_missing:
							continue
						// TODO: implement
						default:
							result = result.filter(by: \.editorVersion, equals: editorVersion)
					}
			}
		}

		return result
	}

	private var projects: [ProjectMetadata] {
		projectSearchResults
			.sorted(
				by: appSettings.projects.sortCriteria,
				order: appSettings.projects.sortOrder
			)
	}

	var body: some View {
		List(projects) { project in
			let binding = Binding<ProjectMetadata>(
				get: { project },
				set: { projectCache[$0.url] = $0 }
			)

			ProjectListItem(binding)
				.swipeActions(edge: .leading, allowsFullSwipe: true) {
					Button("Pin", systemImage: "pin") {
						binding.wrappedValue.pinned.toggle()
					}
					.tint(.orange)
				}
		}

		.searchable(text: $searchQuery, editableTokens: $searchTokens, token: SearchTokenEditor.init)
		.searchSuggestions { SearchTokenSuggestions(searchTokens) }
	}
}
