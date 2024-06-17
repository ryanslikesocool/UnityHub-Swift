import SwiftUI

struct SearchTokenSuggestions: View {
	private let tokens: [ProjectSearchToken]

	init(_ tokens: [ProjectSearchToken]) {
		self.tokens = tokens
	}

	var body: some View {
		if !tokens.contains(where: { $0.kind == .isPinned }) {
			Text("Pinned").searchCompletion(
				ProjectSearchToken.isPinned(true)
			)
		}

		if !tokens.contains(where: { $0.kind == .editorVersion }) {
			// TODO: only show if more than one install across all projects
			Text("Editor Version").searchCompletion(
				ProjectSearchToken.editorVersion(.zero)
			)
		}
	}
}
