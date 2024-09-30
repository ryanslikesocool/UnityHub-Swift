import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct InstallationList: View {
	@Environment(\.scenePhase) private var scenePhase

	@AppSetting(installation: \.sortOrder) private var sortOrder
	@Cache(InstallationCache.self) private var installations

	@EnvironmentObject private var model: InstallationsModel

	public init() { }

	public var body: some View {
		CacheListView(
			items: $installations.installations,
			itemFilter: filterFunction,
			item: Item.init,
			noItems: EmptyList.init
		)
		.searchable(text: $model.search.query, editableTokens: $model.search.tokens, token: SearchTokenEditor.init)
		.searchSuggestions { SearchTokenSuggestions() }
		.onAppear { installations.validateInstallations() }
		.onChange(of: scenePhase) { installations.validateInstallations() }
	}
}

// MARK: - Functions

private extension InstallationList {
	func filterFunction(installations: [InstallationMetadata]) -> [InstallationMetadata] {
		let result = model.search.filterFunction(installations: installations)

		return result
			.sorted(
				by: { try? $0.version },
				order: sortOrder
			)
	}
}
