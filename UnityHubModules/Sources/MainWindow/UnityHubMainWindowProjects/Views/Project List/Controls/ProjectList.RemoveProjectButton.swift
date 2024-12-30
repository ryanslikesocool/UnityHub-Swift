import SwiftUI
import UnityHubCommon

extension ProjectList {
	struct RemoveProjectButton: View {
		private let projectURL: URL

		public init(at projectURL: URL) {
			self.projectURL = projectURL
		}

		public var body: some View {
			Button(
				role: .destructive,
				action: buttonAction,
				label: Label.remove
			)
			.keyboardShortcut(.delete)
		}
	}
}

// MARK: - Functions

private extension ProjectList.RemoveProjectButton {
	func buttonAction() {
		Event.Project.remove.send(projectURL)
	}
}