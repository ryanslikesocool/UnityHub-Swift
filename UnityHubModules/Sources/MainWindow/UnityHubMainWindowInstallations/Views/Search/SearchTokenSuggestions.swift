import SwiftUI
import UnityHubCommonViews
import UnityHubStorageCommon
import UnityHubStorageInstallations

struct SearchTokenSuggestions: View {
	@CacheFile(InstallationCache.self) private var installations

	@EnvironmentObject private var model: InstallationsModel

	private var tokens: [SearchToken] { model.search.tokens }

	public init() { }

	public var body: some View {
		if installations.installations.count > 1 {
			makeLTSSuggestion()

			makePrereleaseSuggestion()

			makeMajorVersionSuggestion()
		}
	}
}

// MARK: - Supporting Views

private extension SearchTokenSuggestions {
	@ViewBuilder
	func makeLTSSuggestion() -> some View {
		if
			installations.installations.contains(where: { element in (try? element.version)?.isLTS == true }),
			!tokens.contains(where: { element in element.kind == .lts })
		{
			Text(.unityEditorVersion.longTermSupport)
				.searchCompletion(
					SearchToken.lts(true)
				)
		}
	}

	@ViewBuilder
	func makePrereleaseSuggestion() -> some View {
		if
			installations.installations.contains(where: { element in (try? element.version)?.isPrerelease == true }),
			!tokens.contains(where: { element in element.kind == .prerelease })
		{
			Text(.unityEditorVersion.prerelease)
				.searchCompletion(
					SearchToken.prerelease(true)
				)
		}
	}

	@ViewBuilder
	func makeMajorVersionSuggestion() -> some View {
		let uniqueMajorVersions = installations.uniqueMajorVersions
		if
			uniqueMajorVersions.count > 1,
			!tokens.contains(where: { element in element.kind == .majorVersion })
		{
			Text(.unityEditorVersion.semanticVersion.major)
				.searchCompletion(
					SearchToken.majorVersion(uniqueMajorVersions[uniqueMajorVersions.count - 1])
				)
		}
	}
}
