import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

struct SearchTokenSuggestions: View {
	@CacheFile(ProjectCache.self) private var projects

	private let tokens: [SearchToken]

	init(_ tokens: [SearchToken]) {
		self.tokens = tokens
	}

	var body: some View {
		if projects.projects.count > 1 {
			if
				projects.projects.contains(where: { $0.pinned }),
				!tokens.contains(where: { $0.kind == .pinned })
			{
				Label.pinned().searchCompletion(
					SearchToken.pinned(true)
				)
			}

			if
				projects.projectEditorVersions.count > 1,
				!tokens.contains(where: { $0.kind == .editorVersion })
			{
				Text("Editor Version").searchCompletion(
					SearchToken.editorVersion(.zero)
				)
			}
		}
	}
}
