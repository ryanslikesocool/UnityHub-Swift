import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension InstallationList {
	struct EmptyList: View {
		var body: some View {
			EmptyListView {
				Label("No Installations", systemImage: Constant.Symbol.tray)
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

// MARK: - Supporting

private extension InstallationList.EmptyList {
	@ViewBuilder
	func makePromptContent() -> some View {
		Button.downloadInstallation()

		if #available(macOS 15, *) {
			makePromptActionSeparator()
				.ignoresEqualSizeLayout()
		} else {
			makePromptActionSeparator()
		}

		Button.locateInstallation()
	}

	func makePromptActionSeparator() -> some View {
		Text("or")
			.foregroundStyle(.secondary)
	}
}