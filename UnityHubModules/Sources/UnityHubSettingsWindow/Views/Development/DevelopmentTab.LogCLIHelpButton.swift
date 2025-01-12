import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubShell

extension DevelopmentTab {
	struct LogCLIHelpButton: View {
		public init() { }

		public var body: some View {
			LabeledContent(content: {
				TaskButton("Log Official CLI Help", action: buttonAction)
			}, label: EmptyView.init)
		}
	}
}

// MARK: - Functions

private extension DevelopmentTab.LogCLIHelpButton {
	func buttonAction() async {
		do {
			let result = try await Shell.officialHub(.headless, .help)
			print(result)
		} catch {
			Logger.module.error("""
			Failed to execute official hub help command:
			\(error.localizedDescription)
			""")
		}
	}
}
