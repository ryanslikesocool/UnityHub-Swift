import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension InstallationList {
	struct EmptyList: View {
		public init() { }

		public var body: some View {
			EmptyListView {
				Label("No Installations", systemImage: Symbol.tray)
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
		DownloadInstallationButton()

		if #available(macOS 15, *) {
			makePromptActionSeparator()
				.ignoresEqualSizeLayout()
		} else {
			makePromptActionSeparator()
		}

		LocateInstallationButton()
	}

	func makePromptActionSeparator() -> some View {
		Text("or")
			.foregroundStyle(.secondary)
	}
}
