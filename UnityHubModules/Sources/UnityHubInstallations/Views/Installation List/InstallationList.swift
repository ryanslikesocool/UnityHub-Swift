import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct InstallationList: View {
	@Environment(\.scenePhase) private var scenePhase

	@AppSetting(installation: \.sortOrder) private var sortOrder
	@Cache(InstallationCache.self) private var installations

	@State private var searchQuery: String = ""
	@State private var searchTokens: [SearchToken] = []

	var body: some View {
		CacheListView(
			items: $installations.installations,
			itemFilter: filterFunction,
			item: Item.init,
			noItems: EmptyList.init
		)
		.searchable(text: $searchQuery, editableTokens: $searchTokens, token: SearchTokenEditor.init)
		.searchSuggestions { SearchTokenSuggestions(searchTokens) }
		.onAppear(perform: installations.validateInstallations)
		.onChange(of: scenePhase, installations.validateInstallations)
	}
}

// MARK: - Functions

private extension InstallationList {
	func filterFunction(installations: [InstallationMetadata]) -> [InstallationMetadata] {
		var result: [InstallationMetadata] = installations

		if !searchQuery.isEmpty {
			result = result.filter { installation in
				(try? installation.version)?.description.localizedStandardContains(searchQuery) == true
			}
		}

		for token in searchTokens {
			result = switch token {
				case let .lts(state): result.filter { (try? $0.version)?.isLTS == state }
				case let .prerelease(state): result.filter { (try? $0.version)?.isPrerelease == state }
				case let .majorVersion(value): result.filter { (try? $0.version)?.major == value }
			}
		}

		return result
			.sorted(
				by: { try? $0.version },
				order: sortOrder
			)
	}
}
