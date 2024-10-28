import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension ProjectList {
	struct EmptyList: View {
		var body: some View {
			EmptyListView {
				Label("No Projects", systemImage: Symbol.cube)
			} prompt: {
				if #available(macOS 15, *) {
					EqualWidthHStack(content: makePromptContent)
						.buttonStyle(.automatic.expandedLabel())
				} else {
					HStack(content: makePromptContent)
				}
			}
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.EmptyList {
	@ViewBuilder
	func makePromptContent() -> some View {
		Button.createProject()

		if #available(macOS 15, *) {
			makePromptActionSeparator()
				.ignoresEqualSizeLayout()
		} else {
			makePromptActionSeparator()
		}

		Button.locateProject()
	}

	func makePromptActionSeparator() -> some View {
		Text("or")
			.foregroundStyle(.secondary)
	}
}
