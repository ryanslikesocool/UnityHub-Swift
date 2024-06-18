import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct ProjectList: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var projectCache: ProjectCache = .shared

	@State private var searchQuery: String = ""
	@State private var searchTokens: [ProjectSearchToken] = []

	private var filteredProjects: [ProjectMetadata] {
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
			.sorted(
				by: appSettings.projects.sortCriteria,
				order: appSettings.projects.sortOrder
			)
	}

	var body: some View {
		lazy var filteredProjects = self.filteredProjects

		Group {
			if projectCache.projects.isEmpty {
				noProjects
			} else if filteredProjects.isEmpty {
				noSearchResults
			} else {
				list
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)

		.searchable(text: $searchQuery, editableTokens: $searchTokens, token: SearchTokenEditor.init)
		.searchSuggestions { SearchTokenSuggestions(searchTokens) }
	}
}

// MARK: - Supporting Views

private extension ProjectList {
	var list: some View {
		List(filteredProjects) { project in
			let binding = Binding<ProjectMetadata>(
				get: { project },
				set: { projectCache[$0.url] = $0 }
			)

			Item(binding)
				.swipeActions(edge: .leading, allowsFullSwipe: true) {
					Button("Pin", systemImage: "pin") {
						binding.wrappedValue.pinned.toggle()
					}
					.tint(.orange)
				}
				.swipeActions(edge: .trailing) {
					Button("Remove", systemImage: "trash") {
						Event.removeProject(binding.wrappedValue.url)
					}
					.tint(.red)
				}
		}
	}

	var noProjects: some View {
		VStack {
			Group {
				Image(systemName: "cube")
					.font(.largeTitle)
				Text("No Projects")
					.font(.title3)
			}
			.foregroundStyle(.tertiary)

			Text("Drop a project or")
				.foregroundStyle(.secondary)
			Button("Select", systemImage: "square.and.arrow.down") {
				Event.importProject.send(.add)
			}
			.controlSize(.large)
		}
	}

	var noSearchResults: some View {
		VStack {
			Image(systemName: "magnifyingglass")
				.font(.largeTitle)
			Text("No search results")
				.font(.title3)
		}
		.foregroundStyle(.tertiary)
	}
}
