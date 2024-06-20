import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct InstallationList: View {
	@Bindable private var appSettings: AppSettings = .shared
	@Bindable private var installationsCache: InstallationCache = .shared

	@State private var searchQuery: String = ""
	@State private var searchTokens: [SearchToken] = []

	var body: some View {
		CacheListView(
			items: $installationsCache.installations,
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
		VStack {
			Label("No Installations", systemImage: Constant.Symbol.tray)
				.labelStyle(.large)

			VStack {
				Button(action: { Event.locateInstallation(.add) }, label: Label.locate)

				Text("or")
					.foregroundStyle(.secondary)

				Button(action: { print("\(Self.self).\(#function) is not implemented") }, label: Label.download)
			}
			.controlSize(.large)
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
				order: appSettings.installations.sortOrder
			)
	}
}
