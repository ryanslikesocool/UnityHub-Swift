import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension ProjectList.Item {
	struct IssueMenu: View {
		private let projectURL: URL
		private let flags: ProjectIssueFlags

		init(projectURL: URL, missingProject: Bool, missingInstallation: Bool) {
			self.projectURL = projectURL

			var flags: ProjectIssueFlags = .none
			flags[.missingProject] = missingProject
			flags[.missingInstallation] = missingInstallation
			self.flags = flags
		}

		var body: some View {
			UnityHubCommonViews.IssueMenu(
				flags: flags,
				action: action,
				itemLabel: itemLabel
			)
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.Item.IssueMenu {
	@ViewBuilder func itemLabel(flag: ProjectIssueFlags) -> some View {
		switch flag {
			case .missingProject: Text("Missing Project")
			case .missingInstallation: Text("Missing Installation")
			default: preconditionFailure("Unsupported \(ProjectIssueFlags.self) case \(flag).")
		}
	}
}

// MARK: - Actions

private extension ProjectList.Item.IssueMenu {
	func action(flag: ProjectIssueFlags) {
		switch flag {
			case .missingProject: Event.Project.missing.send(projectURL)
			case .missingInstallation: print("\(Self.self).\(#function) is not implemented")
			default: preconditionFailure("Unsupported \(ProjectIssueFlags.self) case \(flag).")
		}
	}
}
