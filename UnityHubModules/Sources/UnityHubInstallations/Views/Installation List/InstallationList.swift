import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct InstallationList: View {
	@AppSetting(installation: \.sortOrder) private var sortOrder
	@Cache(InstallationCache.self) private var installations

	@State private var searchQuery: String = ""
	@State private var searchTokens: [SearchToken] = []

	var body: some View {
		CacheListView(
			items: $installations.installations,
			itemFilter: filterFunction,
			item: Item.init,
			noItems: noInstallations
		)
		.searchable(text: $searchQuery, editableTokens: $searchTokens, token: SearchTokenEditor.init)
		.searchSuggestions { SearchTokenSuggestions(searchTokens) }
	}
}

// MARK: - Supporting Views

private extension InstallationList {
	func noInstallations() -> some View {
		EmptyListView {
			Label("No Installations", systemImage: Constant.Symbol.tray)
		} prompt: {
			Button(action: { Event.locateInstallation(.add) }, label: Label.locate)
			Text("or")
			Button(action: { print("\(Self.self).\(#function) is not implemented") }, label: Label.download)
		}
	}
}

// MARK: - Functions

private extension InstallationList {
	func filterFunction(installations: [InstallationMetadata]) -> [InstallationMetadata] {
		var result: [InstallationMetadata] = installations

		if !searchQuery.isEmpty {
			result = result.filter { installation in
				installation.version?.description.localizedStandardContains(searchQuery) ?? false
			}
		}

		for token in searchTokens {
			result = switch token {
				case let .lts(state): result.filter { $0.version?.isLTS == state }
				case let .prerelease(state): result.filter { $0.version?.isPrerelease == state }
				case let .majorVersion(value): result.filter { $0.version?.major == value }
			}
		}

		return result
			.sorted(
				by: \.version,
				order: sortOrder
			)
	}
}
