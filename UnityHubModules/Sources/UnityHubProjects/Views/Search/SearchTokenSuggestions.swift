import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct SearchTokenSuggestions: View {
	@Bindable private var projectCache: ProjectCache = .shared

	private let tokens: [SearchToken]

	init(_ tokens: [SearchToken]) {
		self.tokens = tokens
	}

	var body: some View {
		if projectCache.projects.count > 1 {
			if
				projectCache.projects.contains(where: { $0.pinned }),
				!tokens.contains(where: { $0.kind == .pinned })
			{
				Label.pinned().searchCompletion(
					SearchToken.pinned(true)
				)
			}

			if
				projectCache.projectEditorVersions.count > 1,
				!tokens.contains(where: { $0.kind == .editorVersion })
			{
				Text("Editor Version").searchCompletion(
					SearchToken.editorVersion(.zero)
				)
			}
		}
	}
}
